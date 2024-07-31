# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

import
  # pkgs/balls,
  pkg/sys/ioqueue,
  pkg/wayland

# suite "basic":
block:
  let wl = wayland.newClient()
  let path = wayland.socketPath()
  echo "connect to ", path
  wl.connect(path)
  wl.dispatch()

  run()
