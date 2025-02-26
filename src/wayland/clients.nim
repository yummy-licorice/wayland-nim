# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

## This module implements sending requests and handling events
## on a Wayland socket.

const traceWayland {.booldefine.}: bool = true

import
  std/posix,
  cps,
  ioqueue, sockets

type
  Client* = ref object
    ## Object containing a socket and bindings between
    ## ids on the wire and object local objects.
    binds: seq[Wl_object]
    sock: Socket
    alive: bool

  Socket = AsyncConn[sockets.Protocol.Unix]

  Wl_object* = ref object of RootObj
    ## Base object of all local Wayland objects.
    ## Objects inheriting this must implement
    ## the `dispatchEvent` event.
    client: Client
    oid: Oid

  Oid* = distinct uint32
    ## Object-identifier.

  Opcode* = uint16
    ## Opcode for requests and events.

  SignedDecimal* = distinct uint32
    ## Signed 24.8 decimal numbers.
    ## It is a signed decimal type which offers a sign bit,
    ## 23 bits of integer precision and 8 bits of decimal precision.

  FD* = distinct cint
    ## "File" Descriptor.

  Message* = object
    ## Complete message buffer to recieve or send on a socket.
    buf: seq[uint32]
    fds: seq[FD]

  ProtocolError* = object of CatchableError
    ## Exception for Wayland protocol errors.
    opcode*: Opcode

using client: Client
using obj: Wl_object
using oid: Oid
using msg: Message

func `==`*(a, b: Oid): bool {.borrow.}
proc `$`*(oid: Oid): string {.borrow.}

func `==`*(a, b: SignedDecimal): bool {.borrow.}

proc `$`*(obj: Wl_object): string = "Wl_object"

proc newUnknownEventError*(face: static[string]; opcode: Opcode): ref ProtocolError =
  new result
  result.msg = "unknown event at " & face
  result.opcode = opcode

proc oid*(msg: Message): Oid  {.inline.} = msg.buf[0].Oid
  ## Accessor for message destination object id.

proc size*(msg: Message): int  {.inline.} = int(msg.buf[1] shr 16)
  ## Accessor for message size in bytes.

proc opcode*(msg: Message): Opcode {.inline.} = msg.buf[1].uint16
  ## Accessor for message opcode.

when traceWayland:
  import std/strutils
  proc `$`*(msg: Message): string =
    result = "$1 $2 ($3 $4)" % [
        msg.buf[0].toHex(8),
        msg.buf[1].toHex(8),
        msg.size.toHex(4),
        msg.opcode.toHex(4),
      ]
    if msg.size > 8:
      result.add " "
      result.add msg.buf[2].toHex(8)
      if msg.size > 12:
        result.add "…"

proc wordPos*(msg: Message): int  {.inline.} = msg.size shr 2

proc `size=`*(msg: var Message; n: Natural) {.inline.} =
  assert n <= 0xffff
  assert n <= (msg.buf.len shl 2)
  msg.buf[1] = (msg.buf[1] and 0xffff'u32) or (n.uint32 shl 16)

proc `wordSize=`*(msg: var Message; n: Natural) {.inline.} =
  msg.size = n shl 2

proc oid*(obj: Wl_object): Oid =
  obj.oid

proc client*(obj: Wl_object): Client =
  ## Access the `Client` that `obj` is bound to.
  assert not obj.client.isNil
  obj.client

proc initMessage(oid: Oid; op: Opcode; wordLen: int): Message =
  assert wordLen >= 2
  result.buf.setLen(wordLen)
  result.buf[0] = oid.uint32
  result.buf[1] = (8 shl 16) or op.uint32

func wordLen(x: SomeInteger | Oid | Wl_object | enum): int = 1

proc marshal[T: SomeUnsignedInt|enum](msg: var Message; n: T) =
  let posW = msg.wordPos
  msg.buf[posW] = uint32 n
  assert msg.buf[posW].T == n
  msg.wordSize = posW.succ

proc marshal(msg: var Message; n: SomeSignedInt) =
  assert n < int32.high
  assert n > int32.low
  marshal(msg, cast[uint32](int32 n))

func wordLen(s: string): int = (s.len + 4) and not(3)

proc marshal(msg: var Message; s: string) =
  let
    posW = msg.wordPos
    sLenB = s.len.succ # Add one for null termination.
    sLenW = (sLenB + 3) shr 2 # Length in words, rounded up.
    msgLenW = posW + 1 + sLenW
  msg.buf[posW] = sLenB.uint32
  msg.buf[msgLenW.pred] = 0 # Nullify the padding word.
  copyMem(msg.buf[posW.succ].addr, s[0].addr, s.len)
  msg.wordSize = msgLenW

proc marshal(msg: var Message; oid: Oid) {.inline.} =
  marshal(msg, oid.uint32)

template write(s: Socket; p: pointer; n: int): int =
  ## Fuck type safety theatre.
  write(s, cast[ptr UncheckedArray[byte]](p), n)

proc sendmsg(sock: Socket; msg: ptr Tmsghdr; flags: cint): int {.asyncio.} =
  while true:
    result = sendmsg(sock.fd.SocketHandle, msg, flags)
    if result < -1:
      case errno
      of EINTR: discard
      of EAGAIN:
        wait(sock.fd, Event.Write)
      else:
        raise newException(IOError, "sendmsg failed")
    else:
      return

proc sendRequest(client: Client; msg: Message) {.asyncio.} =
  when traceWayland:
    stderr.writeLine "C: ", msg
  let n = msg.size
  if msg.fds.len > 0:
    var
      fdsSize = sizeof(FD) * msg.fds.len
      cmsgBuf = newSeq[byte](int CMSG_SPACE(csize_t fdsSize))
      cmsgp = cast[ptr Tcmsghdr](cmsgBuf[0].addr)
      iov = IOVec(
          iov_base: msg.buf[0].addr,
          iov_len: n.csize_t,
        )
      msgh = Tmsghdr(
          msg_iov: iov.addr,
          msg_iov_len: 1,
          msg_control: cmsgBuf[0].addr,
          msg_controllen: cmsgBuf.len.csize_t,
        )
    cmsgp = CMSG_FIRSTHDR(msgh.addr)
    cmsgp.cmsg_level = SOL_SOCKET
    cmsgp.cmsg_type = SCM_RIGHTS;
    cmsgp.cmsg_len = CMSG_LEN(csize_t fdsSize)
    copyMem(cast[pointer](CMSG_DATA(cmsgp)), msg.fds[0].addr, fdsSize)
    if client.sock.sendmsg(msgh.addr, 0) != n:
      raise newException(IOError, "failed to send Wayland message")
  else:
    if client.sock.write(msg.buf[0].addr, n) != n:
      raise newException(IOError, "failed to send Wayland message")

proc request(client: Client; msg: Message) =
  sendRequest(client, msg)

proc request*(obj: Wl_object; op: Opcode; args: tuple) =
  ## Send an `op` request message to `obj` with `args`.
  assert(obj.oid != 0.Oid, "request object not bound")
  var totalWords = 2
  for arg in fields(args):
    when arg is FD: discard
    else:
      let n = arg.wordLen
      assert n > 0
      totalWords.inc n
  var msg = initMessage(obj.oid, op, totalWords)
  for arg in args.fields:
    when arg is Wl_object:
      if arg.client.isNil:
        obj.client.bindObject(arg)
      assert obj.client == arg.client
      marshal(msg, arg.oid)
    elif arg is FD:
      msg.fds.add arg
    else:
      marshal(msg, arg)
  assert totalWords <= msg.buf.len
  request(obj.client, msg)

proc `[]`(client; oid): Wl_object =
  var i = oid.int
  if 0 < i and i < client.binds.len:
    result = client.binds[i]
    assert result.oid == oid
  else:
    raise newException(KeyError, "Wayland object ID not registered locally")

proc unmarshal[T: int|uint|enum|Oid|SignedDecimal](client; msg: Message; woff: int; n: var T): int =
  result = 1
  n = msg.buf[woff].T

proc unmarshal(client; msg; woff: int; s: var string): int =
  let len = msg.buf[woff].int
  assert len < 0x1000
  s.setLen len.pred
  if s.len > 0:
    copyMem(s[0].addr, msg.buf[woff.succ].addr, s.len)
  succ((len + 3) shr 2)

proc unmarshal(client; msg; woff: int; warr: var seq[uint32]): int =
  var
    bLen = msg.buf[woff].int
    wLen = bLen shr 2
  result = wLen.succ
  if (bLen and 3) != 0 or woff + result > msg.buf.len:
    raise newException(ProtocolError, "received invalid array")
  warr.setLen(wLen)
  if wLen > 0:
    copyMem(warr[0].addr, msg.buf[woff.succ].addr, bLen)

proc unmarshal*(obj; msg; args: var tuple) =
  ## Unmarshal `args` from `msg`.
  var off = 2
  for arg in args.fields:
    when arg is Wl_object:
      arg = (typeof arg) obj.client[msg.buf[off].Oid]
      off.inc
    elif arg is FD:
      raiseAssert "FD unmarshalling not implemented"
    else:
      off.inc unmarshal(obj.client, msg, off, arg)
  assert (off shl 2) == msg.size

method dispatchEvent(wlo: Wl_object; msg: Message) {.base.} =
  ## Method to be generated for a protocol.
  raiseAssert "dispatchEvent not implemented for this object"

template eventNotImplemented*(name: string) =
  when not defined(release):
    raiseAssert(name & " event method not implemented")

proc bindObject*(client; obj: Wl_object) =
  ## Bind `obj` to an `Oid` at `client`.
  assert obj.client.isNil
  assert client.binds.len < 0xfeffffff
  client.binds.add obj
  obj.oid = client.binds.high.Oid
  obj.client = client

proc newClient*: Client =
  ## Allocate a new `Client`.
  Client(binds: newSeqOfCap[Wl_object](32))

template read(s: Socket; p: pointer; n: int): int =
  ## Fuck type safety theatre.
  read(s, cast[ptr UncheckedArray[byte]](p), n)

proc close*(client) =
  ## Stop event dispatching and close the socket at `client`.
  client.alive = false
  client.sock.close()

proc dispatch*(client: Client) {.asyncio.} =
  ## Dispatch events in a loop at `client`.
  var msg = Message(buf: newSeq[uint32](0x400))
  assert client.alive
  while client.alive:
    var n = client.sock.read(msg.buf[0].addr, 8)
    if n != 8:
      if n == 0:
        client.close()
        break
      else:
        raise newException(IOError, "failed to read Wayland message header")
    when traceWayland:
      stderr.writeLine "S: ", $msg
    let msgLen = msg.size
    if msgLen < 8:
      raise newException(IOError, "Wayland message size is too small")
    elif (msgLen and 3) != 0:
      raise newException(IOError, "Wayland message size is misaligned")
    elif msgLen > 8:
      let wordLen = msgLen shr 2
      if msg.buf.len < wordLen:
        msg.buf.setLen(wordLen)
      n.inc client.sock.read(msg.buf[2].addr, msg.size.int - 8)
      if n != msgLen: raise newException(IOError, "Invalid read of Wayland socket. Read " & $n & " bytes of " & $msgLen)
    let obj = client[msg.oid]
    if obj.isNil:
      client.close()
      raise newException(IOError, "Wayland event received for non-existent object")
    else:
      obj.dispatchEvent(msg)

proc connectSocket*(client: Client; path: string) {.asyncio.} =
  ## Connect to the Wayland socket at `path`.
  assert not client.alive
  client.sock = connectUnixAsync(path)
  client.alive = true
  client.binds.setLen(1)
  client.binds[0] = nil
