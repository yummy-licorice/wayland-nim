# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

# Taken from https://wayland-book.com/surfaces/shared-memory.html.

import
  std/[posix, random],
  ./clients,
  ./globals

type
  ShmPool* = ref object of Wl_shm_pool
    ## A shared memory pool.
    buffers: Buffer # Tail of Buffer chain.
    base: uint
    size: int
    fd: cint

  Buffer* {.final, acyclic.} = ref object of Wl_buffer
    ## Content for a wl_surface.
    prev: Buffer # Previous buffer in chain.
    base*: uint
    len*, width*, height*, stride*: int
    format: Wl_shm_format

  UnsafeBuffer = distinct Buffer

proc size*(pool: ShmPool): int = pool.size

proc newShmPool(size: Natural): ShmPool =
  ## See
  result = ShmPool(size: size)
  var name = [ '/', 'w', 'l', '-', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0']
  randomize()
  while true:
    for i in 4..<name.high:
      name[i] = rand(range['A'..'z'])
    result.fd = shm_open(name[0].addr, O_RDWR or O_CREAT or O_EXCL, 0600)
    if result.fd < 0:
      if errno != EEXIST:
        raise newException(IOError, "failed to create shm file")
    else:
      discard shm_unlink(name[0].addr)
        # The shm will persist until the FD is closed.
      break
  assert result.fd > 0
  while true:
    let res = ftruncate(result.fd, size)
    if res < 0:
      if errno != EINTR:
        discard close(result.fd)
        raise newException(IOError, "failed to allocate shm file")
    else:
      result.base = cast[uint](mmap(nil, size, PROT_READ or PROT_WRITE, MAP_SHARED, result.fd, 0))
      return

proc createPool*(shm: Wl_shm; size: Natural): ShmPool =
  ## Create a new `ShmPool` at a `Wl_shm`.
  result = newShmPool(size)
  shm.create_pool(result, result.fd.FD, result.size)

proc close*(pool: ShmPool) =
  ## Close a `pool` and invalidate its buffers.
  var buf = pool.buffers.move
  while not buf.isNil:
    reset buf.base
    reset buf.height
    reset buf.stride
    buf = buf.prev.move
      # Invalidate the buffer chain.
  discard munmap(cast[pointer](pool.base), pool.size)
  discard close(pool.fd)
  pool.destroy()

proc createBuffer*(pool: ShmPool; off, w, h, stride: int; f: Wl_shm_format): Buffer =
  ## Create a new `Buffer` at a `ShmPool`.
  # doAssert w * sizeof(T) < stride
  var bufBase = pool.base + off.uint
  doAssert (bufBase + uint(w * stride)) <= (pool.base + pool.size.uint)
  new result
  result.prev = pool.buffers
  result.base = bufBase
  result.width = w
  result.height = h
  result.stride = stride
  result.format = f
  pool.buffers = result
  pool.create_buffer(result, off, w, h, stride, f)

method release(buf: Buffer) = discard

# The following copied from Treeform's Pixie library.

template dataIndex*(buf: Buffer, x, y: int): int =
  buf.width * y + x

func inside*(buf: Buffer; x, y: int): bool {.inline.} =
  ## Returns true if (x, y) is inside the image.
  x >= 0 and x < buf.width and y >= 0 and y < buf.height

template unsafe*(buf: Buffer): UnsafeBuffer =
  cast[UnsafeBuffer](buf)

template `[]=`*[T](buf: Buffer, x, y: int; pixel: T) =
  ## Gets a color from (x, y) coordinates.
  ## * No bounds checking *
  ## Make sure that x, y are in bounds.
  ## Failure in the assumptions will cause unsafe memory reads.
  cast[ptr UncheckedArray[T]](buf.base)[buf.dataIndex(x, y)] = pixel
