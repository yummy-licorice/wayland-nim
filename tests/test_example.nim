# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

import
  # pkgs/balls,
  pkg/sys/ioqueue,
  pkg/wayland,
  pkg/wayland/[globals, shared_memories, xdg_shell]

const
  width = 160
  height = 120

type Pcg16 = object
  state, inc: uint32

proc initPcg16: Pcg16 =
  Pcg16(
      state: 0xec02d89b'u32,
      inc: 0x94b95bdb'u32,
    )

proc next(rng: var Pcg16): uint16 {.exportc.} =
  if (rng.inc == 0): rng = initPcg16()
  var oldState = rng.state
  rng.state = oldState * 747796405 + rng.inc
  var xorShifted = ((oldstate shr 10) xor oldstate) shr 12
  var rot = int64 oldstate shr 28
  uint16 (xorShifted shr rot) or (xorShifted shl ((-rot) and 15))

type Shm {.final.} = ref object of Wl_shm

method format(shm: Shm; format: Wl_shm_format) =
  echo "wl_shm supports format ", format

type Compositor {.final.} = ref object of Wl_compositor

type
  WlSurface {.final.} = ref object of globals.Wl_surface
    buffer: Buffer

proc createSurface(comp: Compositor): WlSurface =
  new result
  comp.create_surface(result)

method preferred_buffer_scale(surf: WlSurface; factor: int) =
  echo "server prefers buffer scale of ", factor

type
  PaintCallback {.final.} = ref object of Wl_callback
    surf: WlSurface
    rng: Pcg16

method done(cb: PaintCallback; data: uint) =
  var buf = cb.surf.buffer
  for y in 0..<height:
    for x in 0..<width:
      buf[x, y] = cb.rng.next()
  inc(cb.rng.inc, data)
  cb.surf.attach(buf, 0, 0)
  cb.surf.damage(0, 0, width, height)
  cb.surf.frame(cb)
  cb.surf.commit()

type Wm {.final.} = ref object of Xdg_wm_base

method ping(wm: Wm; serial: uint) =
  wm.pong(serial)
  echo "ponging server"

type
  WmSurface {.final.} = ref object of Xdg_surface
    wl: WlSurface
    active: bool

proc getSurface(wm: Wm; surf: WlSurface): WmSurface =
  result = WmSurface(wl: surf)
  wm.get_xdg_surface(result, surf)

method configure(surf: WmSurface; serial: uint) =
  surf.ack_configure(serial)
  if not surf.active:
    surf.active = true
    PaintCallback(surf: surf.wl).done(1)
      # Start a runaway painting frame callback.

type WmToplevel {.final.} = ref object of Xdg_toplevel

proc getToplevel(surf: WmSurface): WmToplevel =
  new result
  surf.get_toplevel(result)

method wm_capabilities(toplevel: WmToplevel; ablities: seq[uint32]) =
  for abl in ablities:
    echo "WM supports ", Xdg_toplevel_wm_capabilities(abl), " for this surface"

method configure(toplevel: WmToplevel; width, height: int; states: seq[uint32]) =
  for st in states:
    echo "toplevel state ", width, "x", height, " ", Xdg_toplevel_state(st)

method close(toplevel: WmToplevel) =
  quit()

type
  Display {.final.} = ref object of Wl_display
    comp: Compositor
    shm: Shm
    wm: Wm

proc newDisplay: Display =
  ## Allocate a new `Display` object.
  new result

method delete_id(disp: Display; id: uint) =
  discard # Server will send this for the id on the frame callback.

proc isReady(disp: Display): bool =
  not(disp.comp.isNil or disp.shm.isNil or disp.wm.isNil)

proc showPattern(disp: Display) =
  let
    pool = disp.shm.createPool(width * height * 2 * 2)
    surface = disp.comp.createSurface()
    wmSurface = disp.wm.getSurface(surface)
    toplevel = wmSurface.getToplevel()
  toplevel.set_title("Nim Wayland test")
  toplevel.set_app_id("test_example")
  surface.buffer = pool.createBuffer(0, width, height, width*2, rgb565)
  surface.commit()

type
  Registry {.final.} = ref object of Wl_registry
    disp: Display

proc getRegistry(disp: Display) =
  ## Create a new `Registry` object and send it to the server.
  disp.get_registry(Registry(disp: disp))

method error(display: Display; obj: Wl_object; code: uint; message: string) =
  raise newException(ProtocolError, message)

method global(reg: Registry; name: uint; face: string; version: uint) =
  ## Handle global objects.
  echo "server announces global ", face, " v", version
  case face
  of "wl_compositor":
    assert reg.disp.comp.isNil
    new reg.disp.comp
    reg.bind(name, face, version, reg.disp.comp)
    if reg.disp.isReady:
      reg.disp.showPattern()

  of "wl_shm":
    assert reg.disp.shm.isNil
    new reg.disp.shm
    reg.bind(name, face, version, reg.disp.shm)
    if reg.disp.isReady:
      reg.disp.showPattern()

  of "xdg_wm_base":
    assert reg.disp.wm.isNil
    new reg.disp.wm
    reg.bind(name, face, version, reg.disp.wm)
    if reg.disp.isReady:
      reg.disp.showPattern()

  else: discard
  # TODO: interface versions should be checked for compatibility.

# suite "basic":
block:
  let
    wl = wayland.newClient()
    path = wayland.socketPath()
    display = newDisplay()

  proc runner() {.asyncio.} =
    echo "connect to ", path
    wl.connect(display, path)
      # Connect to Wayland.

    display.getRegistry()
      # Send over the first object.

    wl.dispatch()
      # Dispatch messages until disconnected.

  runner()
  run()
