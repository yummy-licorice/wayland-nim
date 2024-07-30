# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

import
  pkg/cps,
  pkg/sys/[ioqueue, sockets]

type
  Client* = ref object
    binds: seq[Wl_object]
    sock: Socket
    alive: bool

  Socket = AsyncConn[sockets.Protocol.Unix]

  Wl_object* = ref object of RootObj
    client: Client
    oid: Oid

  Oid* = distinct uint32
  SignedDecimal* = distinct uint32
  ItemKind {.pure.} = enum
    integer, decimal, string, obj, newId, sequence, fd
  Item* = object
    case kind*: ItemKind
    of integer:
      integer: uint32
    of decimal:
      decimal: SignedDecimal
    of string:
      string: string
    of obj:
      obj: Wl_object
    of newId:
      newid: Oid
    of sequence:
      sequence: Sequence
    of fd:
      fd: cint
  Sequence* = seq[Item]

  Message* = object
    buf: seq[uint32]

using client: Client
using obj: Wl_object
using oid: Oid
using msg: Message

func `==`*(a, b: Oid): bool {.borrow.}
proc `$`*(oid: Oid): string {.borrow.}

proc oid*(msg: Message): Oid  {.inline.} = msg.buf[0].Oid

proc size*(msg: Message): int  {.inline.} = int(msg.buf[1] shr 16)

proc opcode*(msg: Message): uint16 {.inline.} = msg.buf[1].uint16

when not defined(release):
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
      result.add msg.buf[3].toHex(8)
      if msg.size > 12:
        result.add "…"

proc wordPos*(msg: Message): int  {.inline.} = msg.size shr 2

proc `size=`*(msg: var Message; n: Natural) {.inline.} =
  assert n <= 0xffff
  assert n <= (msg.buf.len shl 2)
  msg.buf[1] = (msg.buf[1] and 0xffff'u32) or (n.uint32 shl 16)

proc `wordSize=`*(msg: var Message; n: Natural) {.inline.} =
  msg.size = n shl 2

proc `oid`*(obj: Wl_object): Oid =
  obj.oid

proc `oid=`*(obj: Wl_object; id: Oid) =
  assert obj.oid == Oid(0), "object oid already set"
  obj.oid = id

proc initMessage(oid: Oid; op: uint16; wordLen: int): Message =
  assert wordLen >= 2
  result.buf.setLen(wordLen)
  result.buf[0] = oid.uint32
  result.buf[1] = (8 shl 16) or op.uint32
  echo "message to ", oid, " is ", wordLen, " words and ", result.size, " bytes"

func wordLen(x: SomeInteger | Oid | Wl_object): int = 1

proc add(msg: var Message; n: SomeUnsignedInt) =
  let posW = msg.wordPos
  msg.buf[posW] = uint32 n
  msg.wordSize = posW.succ

proc add(msg: var Message; n: SomeSignedInt) =
  msg.add cast[uint32](int32 n)

func wordLen(s: string): int = (s.len + 4) and not(3)

proc add(msg: var Message; s: string) =
  let
    posW = msg.wordPos
    sLenB = s.len.succ # Add one for null termination.
    sLenW = (sLenB + 3) shl 2 # Length in words, rounded up.
    msgLenW = posW + 1 + sLenW
  msg.buf[posW] = sLenB.uint32
  msg.buf[msgLenW.pred] = 0 # Nullify the padding word.
  copyMem(msg.buf[posW.succ].addr, s[0].addr, s.len)
  msg.wordSize = msgLenW

proc add(msg: var Message; oid: Oid) {.inline.} =
  msg.add oid.uint32

proc add(msg: var Message; obj: Wl_object) {.inline.} =
  msg.add obj.oid

template write(s: Socket; p: pointer; n: int): int =
  ## Fuck type safety theatre.
  write(s, cast[ptr UncheckedArray[byte]](p), n)

proc sendRequest(client: Client; msg: Message) {.cps: Continuation.} =
  let n = msg.size
  if client.sock.write(msg.buf[0].addr, n) != n:
    raise newException(IOError, "failed to send Wayland message")

proc request(client: Client; msg: Message) =
  sendRequest(client, msg)

proc request*(obj: Wl_object; op: uint16; args: tuple) =
  var totalWords = 2
  for f in args.fields:
    let n = f.wordLen
    echo f.typeOf, " is ", n, " words in length"
    assert n > 0
    totalWords.inc n
  var msg = initMessage(obj.oid, op, totalWords)
  for f in args.fields:
    msg.add f
  request(obj.client, msg)

method dispatch(wlo: Wl_object; msg: Message) {.base.} =
  echo "server sends ", msg

proc `[]`(client; oid): Wl_object =
  var i = oid.int
  if 0 < i and i < client.binds.len:
    result = client.binds[i]
    assert result.oid == oid
  else:
    raise newException(KeyError, "Wayland object ID not registered locally")

proc bindObject*(client; obj: Wl_object) =
  assert obj.client.isNil
  assert client.binds.len < 0xfeffffff
  client.binds.add obj
  obj.oid = client.binds.high.Oid
  obj.client = client

proc newClient*: Client =
  Client(binds: newSeqOfCap[Wl_object](32))

template read(s: Socket; p: pointer; n: int): int =
  ## Fuck type safety theatre.
  read(s, cast[ptr UncheckedArray[byte]](p), n)

proc dispatch*(client: Client) {.asyncio.} =
  echo "dispatch client"
  var msg: Message
  assert client.alive
  while client.alive:
    var n = client.sock.read(msg.buf[0].addr, 8)
    if n != 8:
      raise newException(IOError, "failed to read Wayland message header")
    stderr.writeLine "S: ", $msg
    echo "server message size is ", msg.size
    let msgLen = msg.size
    if msgLen < 8:
      raise newException(IOError, "Wayland message size is too small")
    elif (msgLen and 3) != 0:
      raise newException(IOError, "Wayland message size is misaligned")
    elif msgLen > 8:
      msg.buf.setLen(msgLen shr 2)
      n.inc client.sock.read(msg.buf[2].addr, msg.size.int - 8)
      if n != msg.size.int: raise newException(IOError, "Invalid read of Wayland socket. Read " & $n & " bytes of " & $msg.size)
    let obj = client[msg.oid]
    if not obj.isNil:
      obj.dispatch(msg)
  echo "client not alive"

proc connectSocket*(client: Client; path: string) {.asyncio.} =
  ## Connect to the Wayland socket at `path`.
  assert not client.alive
  client.sock = connectUnixAsync(path)
  client.alive = true
  client.binds.setLen(1)
  client.binds[0] = nil

proc close*(client) =
  client.sock.close()

#[
type
  Header {.packed.} = object
    oid: Oid
    opcode, size: uint16

proc unmarshalArg(msg: Message; woff: int; n: var int): int =
  n = msg.buf[woff].int
  1

proc unmarshalArg(msg: Message; woff: int; s: var string): int =
  let len = msg.buf[woff].int
  assert len < 0x1000
  s.setLen len.pred
  if s.len > 0:
    copyMem(s[0].addr, msg.buf[woff.succ].addr, s.len)
  succ((len + 3) shr 2)

template unmarshal[T: tuple](msg: Message; args: var T) =
  echo "unmarshall ", msg.size shr 2, " words (", msg.size, ")"
  var i = 2 # Word offset after header.
  for f in args.fields:
    i.inc unmarshalArg(msg, i, f)
  echo "unmarshalled ", i, " words"
  assert (i shl 2) == msg.size, "unmarshalled " & $(i shl 2) & " bytes"

proc send(client: Client; msg: Message) {.asyncio.} =
  stderr.writeLine "C: ", $msg
  doAssert client.sock.write(msg.buf[0].addr, msg.size) == msg.hdr.size.int


]#