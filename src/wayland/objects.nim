# SPDX-FileCopyrightText: ☭ Emery Hemingway
# SPDX-License-Identifier: Unlicense

type
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
  Wl_object* = ref object of RootObj
    oid: Oid

func `==`*(a, b: Oid): bool {.borrow.}
proc `$`*(oid: Oid): string {.borrow.}

proc `oid`*(obj: Wl_object): Oid =
  obj.oid

proc `oid=`*(obj: Wl_object; id: Oid) =
  assert obj.oid == Oid(0), "object oid already set"
  obj.oid = id
