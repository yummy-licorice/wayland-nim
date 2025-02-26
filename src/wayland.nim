# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

## High-level client interface to Wayland.

import
  std/os,
  ioqueue,
  ./wayland/[clients, globals]

export clients, globals

proc socketPath*: string =
  ## Determine a reasonable location for the Wayland socket.
  result = getEnv("WAYLAND_DISPLAY")
  if result == "":
    result = "wayland-0"
  if result[0] != '/':
    result = getEnv("XDG_RUNTIME_DIR") / result

proc connect*(client: Client; disp: Wl_display; path: string = socketPath()) {.asyncio.} =
  ## Connect to Wayland socket at `path`.
  connectSocket(client, path)
  client.bindObject disp
  assert disp.oid == Oid(1)
