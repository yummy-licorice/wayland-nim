# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

import
  # pkgs/balls,
  pkg/sys/ioqueue,
  pkg/wayland

type
  TestState = ref object
    discard

type
  Display {.final.} = ref object of Wl_display
    test: TestState

method error(obj: Display; object_id: Oid; code: uint; message: string) =
  raise newException(ProtocolError, message)

type
  Registry {.final.} = ref object of Wl_registry
    test: TestState
    globals*: seq[GlobalEntry]

  GlobalEntry = object
    face: string
    name: uint
    version: uint

method global(reg: Registry; n: uint; f: string; v: uint) =
  echo "new global at ", n, " - ", f, "-", v
  reg.globals.add GlobalEntry(face: f, name: n, version: v)

# suite "basic":
block:
  let
    state = TestState()
    wl = wayland.newClient()
    path = wayland.socketPath()
    display = Display(test: state)
    registry = Registry(test: state)

  proc runner() {.asyncio.} =
    echo "connect to ", path
    wl.connect(display, path)
      # Connect to Wayland.

    display.get_registry(registry)
      # Send over the first object.

    wl.dispatch()
      # Dispatch messages until disconnected.

  runner()
  run()
