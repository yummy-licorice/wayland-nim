# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

# import pkgs/balls

import
  pkg/sys/ioqueue,
  pkg/wayland

# suite "wayland":
block:
  let wl = wayland.newClient()
  let path = wayland.socketPath()
  echo "connect to ", path
  wl.connect(path)

  ## Client dispatching
  wl.dispatch()

  run()
