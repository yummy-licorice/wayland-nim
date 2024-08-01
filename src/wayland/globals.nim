
import
  pkg/wayland/clients

const
  wl_display_sync* = 0
  wl_display_get_registry* = 1
  wl_display_error* = 0
  wl_display_delete_id* = 1
  wl_registry_bind* = 0
  wl_registry_global* = 0
  wl_registry_global_remove* = 1
  wl_callback_done* = 0
  wl_compositor_create_surface* = 0
  wl_compositor_create_region* = 1
  wl_shm_pool_create_buffer* = 0
  wl_shm_pool_destroy* = 1
  wl_shm_pool_resize* = 2
  wl_shm_create_pool* = 0
  wl_shm_format* = 0
  wl_shm_release* = 1
  wl_buffer_destroy* = 0
  wl_buffer_release* = 0
  wl_data_offer_accept* = 0
  wl_data_offer_receive* = 1
  wl_data_offer_destroy* = 2
  wl_data_offer_offer* = 0
  wl_data_offer_finish* = 3
  wl_data_offer_set_actions* = 4
  wl_data_offer_source_actions* = 1
  wl_data_offer_action* = 2
  wl_data_source_offer* = 0
  wl_data_source_destroy* = 1
  wl_data_source_target* = 0
  wl_data_source_send* = 1
  wl_data_source_cancelled* = 2
  wl_data_source_set_actions* = 2
  wl_data_source_dnd_drop_performed* = 3
  wl_data_source_dnd_finished* = 4
  wl_data_source_action* = 5
  wl_data_device_start_drag* = 0
  wl_data_device_set_selection* = 1
  wl_data_device_data_offer* = 0
  wl_data_device_enter* = 1
  wl_data_device_leave* = 2
  wl_data_device_motion* = 3
  wl_data_device_drop* = 4
  wl_data_device_selection* = 5
  wl_data_device_release* = 2
  wl_data_device_manager_create_data_source* = 0
  wl_data_device_manager_get_data_device* = 1
  wl_shell_get_shell_surface* = 0
  wl_shell_surface_pong* = 0
  wl_shell_surface_move* = 1
  wl_shell_surface_resize* = 2
  wl_shell_surface_set_toplevel* = 3
  wl_shell_surface_set_transient* = 4
  wl_shell_surface_set_fullscreen* = 5
  wl_shell_surface_set_popup* = 6
  wl_shell_surface_set_maximized* = 7
  wl_shell_surface_set_title* = 8
  wl_shell_surface_set_class* = 9
  wl_shell_surface_ping* = 0
  wl_shell_surface_configure* = 1
  wl_shell_surface_popup_done* = 2
  wl_surface_destroy* = 0
  wl_surface_attach* = 1
  wl_surface_damage* = 2
  wl_surface_frame* = 3
  wl_surface_set_opaque_region* = 4
  wl_surface_set_input_region* = 5
  wl_surface_commit* = 6
  wl_surface_enter* = 0
  wl_surface_leave* = 1
  wl_surface_set_buffer_transform* = 7
  wl_surface_set_buffer_scale* = 8
  wl_surface_damage_buffer* = 9
  wl_surface_offset* = 10
  wl_surface_preferred_buffer_scale* = 2
  wl_surface_preferred_buffer_transform* = 3
  wl_seat_capabilities* = 0
  wl_seat_get_pointer* = 0
  wl_seat_get_keyboard* = 1
  wl_seat_get_touch* = 2
  wl_seat_name* = 1
  wl_seat_release* = 3
  wl_pointer_set_cursor* = 0
  wl_pointer_enter* = 0
  wl_pointer_leave* = 1
  wl_pointer_motion* = 2
  wl_pointer_button* = 3
  wl_pointer_axis* = 4
  wl_pointer_release* = 1
  wl_pointer_frame* = 5
  wl_pointer_axis_source* = 6
  wl_pointer_axis_stop* = 7
  wl_pointer_axis_discrete* = 8
  wl_pointer_axis_value120* = 9
  wl_pointer_axis_relative_direction* = 10
  wl_keyboard_keymap* = 0
  wl_keyboard_enter* = 1
  wl_keyboard_leave* = 2
  wl_keyboard_key* = 3
  wl_keyboard_modifiers* = 4
  wl_keyboard_release* = 0
  wl_keyboard_repeat_info* = 5
  wl_touch_down* = 0
  wl_touch_up* = 1
  wl_touch_motion* = 2
  wl_touch_frame* = 3
  wl_touch_cancel* = 4
  wl_touch_release* = 0
  wl_touch_shape* = 5
  wl_touch_orientation* = 6
  wl_output_geometry* = 0
  wl_output_mode* = 1
  wl_output_done* = 2
  wl_output_scale* = 3
  wl_output_release* = 0
  wl_output_name* = 4
  wl_output_description* = 5
  wl_region_destroy* = 0
  wl_region_add* = 1
  wl_region_subtract* = 2
  wl_subcompositor_destroy* = 0
  wl_subcompositor_get_subsurface* = 1
  wl_subsurface_destroy* = 0
  wl_subsurface_set_position* = 1
  wl_subsurface_place_above* = 2
  wl_subsurface_place_below* = 3
  wl_subsurface_set_sync* = 4
  wl_subsurface_set_desync* = 5
type
  Wl_display* = ref object of Wl_object
  
  Wl_registry* = ref object of Wl_object
  
  Wl_callback* = ref object of Wl_object
  
  Wl_compositor* = ref object of Wl_object
  
  Wl_shm_pool* = ref object of Wl_object
  
  Wl_shm* = ref object of Wl_object
  
  Wl_buffer* = ref object of Wl_object
  
  Wl_data_offer* = ref object of Wl_object
  
  Wl_data_source* = ref object of Wl_object
  
  Wl_data_device* = ref object of Wl_object
  
  Wl_data_device_manager* = ref object of Wl_object
  
  Wl_shell* = ref object of Wl_object
  
  Wl_shell_surface* = ref object of Wl_object
  
  Wl_surface* = ref object of Wl_object
  
  Wl_seat* = ref object of Wl_object
  
  Wl_pointer* = ref object of Wl_object
  
  Wl_keyboard* = ref object of Wl_object
  
  Wl_touch* = ref object of Wl_object
  
  Wl_output* = ref object of Wl_object
  
  Wl_region* = ref object of Wl_object
  
  Wl_subcompositor* = ref object of Wl_object
  
  Wl_subsurface* = ref object of Wl_object
  
func face*(obj: Wl_display): string =
  "wl_display"

func version*(obj: Wl_display): uint =
  1

proc `sync`*(obj: Wl_display; `callback`: Wl_callback) =
  request(obj, wl_display_sync, (`callback`,))

proc `get_registry`*(obj: Wl_display; `registry`: Wl_registry) =
  request(obj, wl_display_get_registry, (`registry`,))

method `error`*(obj: Wl_display; `object_id`: Oid; `code`: uint;
                `message`: string) {.base.} =
  raiseAssert("wl_display.error not implemented")

method `delete_id`*(obj: Wl_display; `id`: uint) {.base.} =
  raiseAssert("wl_display.delete_id not implemented")

method dispatchEvent*(obj: Wl_display; msg: Message) =
  case msg.opcode
  of wl_display_error:
    var args: (Oid, uint, string)
    unmarshal(obj, msg, args)
    obj.`error`(args[0], args[1], args[2])
  of wl_display_delete_id:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`delete_id`(args[0])
  else:
    raise newUnknownEventError("wl_display", msg.opcode)

func face*(obj: Wl_registry): string =
  "wl_registry"

func version*(obj: Wl_registry): uint =
  1

proc `bind`*(obj: Wl_registry; `name`: uint; `face`: string; `version`: uint;
             `oid`: Oid) =
  request(obj, wl_registry_bind, (`name`, `face`, `version`, `oid`))

method `global`*(obj: Wl_registry; `name`: uint; `interface`: string;
                 `version`: uint) {.base.} =
  raiseAssert("wl_registry.global not implemented")

method `global_remove`*(obj: Wl_registry; `name`: uint) {.base.} =
  raiseAssert("wl_registry.global_remove not implemented")

method dispatchEvent*(obj: Wl_registry; msg: Message) =
  case msg.opcode
  of wl_registry_global:
    var args: (uint, string, uint)
    unmarshal(obj, msg, args)
    obj.`global`(args[0], args[1], args[2])
  of wl_registry_global_remove:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`global_remove`(args[0])
  else:
    raise newUnknownEventError("wl_registry", msg.opcode)

func face*(obj: Wl_callback): string =
  "wl_callback"

func version*(obj: Wl_callback): uint =
  1

method `done`*(obj: Wl_callback; `callback_data`: uint) {.base.} =
  raiseAssert("wl_callback.done not implemented")

method dispatchEvent*(obj: Wl_callback; msg: Message) =
  case msg.opcode
  of wl_callback_done:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`done`(args[0])
  else:
    raise newUnknownEventError("wl_callback", msg.opcode)

func face*(obj: Wl_compositor): string =
  "wl_compositor"

func version*(obj: Wl_compositor): uint =
  6

proc `create_surface`*(obj: Wl_compositor; `id`: Wl_surface) =
  request(obj, wl_compositor_create_surface, (`id`,))

proc `create_region`*(obj: Wl_compositor; `id`: Wl_region) =
  request(obj, wl_compositor_create_region, (`id`,))

func face*(obj: Wl_shm_pool): string =
  "wl_shm_pool"

func version*(obj: Wl_shm_pool): uint =
  2

proc `create_buffer`*(obj: Wl_shm_pool; `id`: Wl_buffer; `offset`: int;
                      `width`: int; `height`: int; `stride`: int; `format`: uint) =
  request(obj, wl_shm_pool_create_buffer,
          (`id`, `offset`, `width`, `height`, `stride`, `format`))

proc `destroy`*(obj: Wl_shm_pool) =
  request(obj, wl_shm_pool_destroy, ())

proc `resize`*(obj: Wl_shm_pool; `size`: int) =
  request(obj, wl_shm_pool_resize, (`size`,))

func face*(obj: Wl_shm): string =
  "wl_shm"

func version*(obj: Wl_shm): uint =
  2

proc `create_pool`*(obj: Wl_shm; `id`: Wl_shm_pool; `fd`: cint; `size`: int) =
  request(obj, wl_shm_create_pool, (`id`, `fd`, `size`))

method `format`*(obj: Wl_shm; `format`: uint) {.base.} =
  raiseAssert("wl_shm.format not implemented")

proc `release`*(obj: Wl_shm) =
  request(obj, wl_shm_release, ())

method dispatchEvent*(obj: Wl_shm; msg: Message) =
  case msg.opcode
  of wl_shm_format:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`format`(args[0])
  else:
    raise newUnknownEventError("wl_shm", msg.opcode)

func face*(obj: Wl_buffer): string =
  "wl_buffer"

func version*(obj: Wl_buffer): uint =
  1

proc `destroy`*(obj: Wl_buffer) =
  request(obj, wl_buffer_destroy, ())

method `release`*(obj: Wl_buffer) {.base.} =
  raiseAssert("wl_buffer.release not implemented")

method dispatchEvent*(obj: Wl_buffer; msg: Message) =
  case msg.opcode
  of wl_buffer_release:
    obj.`release`()
  else:
    raise newUnknownEventError("wl_buffer", msg.opcode)

func face*(obj: Wl_data_offer): string =
  "wl_data_offer"

func version*(obj: Wl_data_offer): uint =
  3

proc `accept`*(obj: Wl_data_offer; `serial`: uint; `mime_type`: string) =
  request(obj, wl_data_offer_accept, (`serial`, `mime_type`))

proc `receive`*(obj: Wl_data_offer; `mime_type`: string; `fd`: cint) =
  request(obj, wl_data_offer_receive, (`mime_type`, `fd`))

proc `destroy`*(obj: Wl_data_offer) =
  request(obj, wl_data_offer_destroy, ())

method `offer`*(obj: Wl_data_offer; `mime_type`: string) {.base.} =
  raiseAssert("wl_data_offer.offer not implemented")

proc `finish`*(obj: Wl_data_offer) =
  request(obj, wl_data_offer_finish, ())

proc `set_actions`*(obj: Wl_data_offer; `dnd_actions`: uint;
                    `preferred_action`: uint) =
  request(obj, wl_data_offer_set_actions, (`dnd_actions`, `preferred_action`))

method `source_actions`*(obj: Wl_data_offer; `source_actions`: uint) {.base.} =
  raiseAssert("wl_data_offer.source_actions not implemented")

method `action`*(obj: Wl_data_offer; `dnd_action`: uint) {.base.} =
  raiseAssert("wl_data_offer.action not implemented")

method dispatchEvent*(obj: Wl_data_offer; msg: Message) =
  case msg.opcode
  of wl_data_offer_offer:
    var args: (string,)
    unmarshal(obj, msg, args)
    obj.`offer`(args[0])
  of wl_data_offer_source_actions:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`source_actions`(args[0])
  of wl_data_offer_action:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`action`(args[0])
  else:
    raise newUnknownEventError("wl_data_offer", msg.opcode)

func face*(obj: Wl_data_source): string =
  "wl_data_source"

func version*(obj: Wl_data_source): uint =
  3

proc `offer`*(obj: Wl_data_source; `mime_type`: string) =
  request(obj, wl_data_source_offer, (`mime_type`,))

proc `destroy`*(obj: Wl_data_source) =
  request(obj, wl_data_source_destroy, ())

method `target`*(obj: Wl_data_source; `mime_type`: string) {.base.} =
  raiseAssert("wl_data_source.target not implemented")

method `send`*(obj: Wl_data_source; `mime_type`: string; `fd`: cint) {.base.} =
  raiseAssert("wl_data_source.send not implemented")

method `cancelled`*(obj: Wl_data_source) {.base.} =
  raiseAssert("wl_data_source.cancelled not implemented")

proc `set_actions`*(obj: Wl_data_source; `dnd_actions`: uint) =
  request(obj, wl_data_source_set_actions, (`dnd_actions`,))

method `dnd_drop_performed`*(obj: Wl_data_source) {.base.} =
  raiseAssert("wl_data_source.dnd_drop_performed not implemented")

method `dnd_finished`*(obj: Wl_data_source) {.base.} =
  raiseAssert("wl_data_source.dnd_finished not implemented")

method `action`*(obj: Wl_data_source; `dnd_action`: uint) {.base.} =
  raiseAssert("wl_data_source.action not implemented")

method dispatchEvent*(obj: Wl_data_source; msg: Message) =
  case msg.opcode
  of wl_data_source_target:
    var args: (string,)
    unmarshal(obj, msg, args)
    obj.`target`(args[0])
  of wl_data_source_send:
    var args: (string, cint)
    unmarshal(obj, msg, args)
    obj.`send`(args[0], args[1])
  of wl_data_source_cancelled:
    obj.`cancelled`()
  of wl_data_source_dnd_drop_performed:
    obj.`dnd_drop_performed`()
  of wl_data_source_dnd_finished:
    obj.`dnd_finished`()
  of wl_data_source_action:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`action`(args[0])
  else:
    raise newUnknownEventError("wl_data_source", msg.opcode)

func face*(obj: Wl_data_device): string =
  "wl_data_device"

func version*(obj: Wl_data_device): uint =
  3

proc `start_drag`*(obj: Wl_data_device; `source`: Wl_data_source;
                   `origin`: Wl_surface; `icon`: Wl_surface; `serial`: uint) =
  request(obj, wl_data_device_start_drag,
          (`source`, `origin`, `icon`, `serial`))

proc `set_selection`*(obj: Wl_data_device; `source`: Wl_data_source;
                      `serial`: uint) =
  request(obj, wl_data_device_set_selection, (`source`, `serial`))

method `data_offer`*(obj: Wl_data_device; `id`: Wl_data_offer) {.base.} =
  raiseAssert("wl_data_device.data_offer not implemented")

method `enter`*(obj: Wl_data_device; `serial`: uint; `surface`: Wl_surface;
                `x`: SignedDecimal; `y`: SignedDecimal; `id`: Wl_data_offer) {.
    base.} =
  raiseAssert("wl_data_device.enter not implemented")

method `leave`*(obj: Wl_data_device) {.base.} =
  raiseAssert("wl_data_device.leave not implemented")

method `motion`*(obj: Wl_data_device; `time`: uint; `x`: SignedDecimal;
                 `y`: SignedDecimal) {.base.} =
  raiseAssert("wl_data_device.motion not implemented")

method `drop`*(obj: Wl_data_device) {.base.} =
  raiseAssert("wl_data_device.drop not implemented")

method `selection`*(obj: Wl_data_device; `id`: Wl_data_offer) {.base.} =
  raiseAssert("wl_data_device.selection not implemented")

proc `release`*(obj: Wl_data_device) =
  request(obj, wl_data_device_release, ())

method dispatchEvent*(obj: Wl_data_device; msg: Message) =
  case msg.opcode
  of wl_data_device_data_offer:
    var args: (Wl_data_offer,)
    unmarshal(obj, msg, args)
    obj.`data_offer`(args[0])
  of wl_data_device_enter:
    var args: (uint, Wl_surface, SignedDecimal, SignedDecimal, Wl_data_offer)
    unmarshal(obj, msg, args)
    obj.`enter`(args[0], args[1], args[2], args[3], args[4])
  of wl_data_device_leave:
    obj.`leave`()
  of wl_data_device_motion:
    var args: (uint, SignedDecimal, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`motion`(args[0], args[1], args[2])
  of wl_data_device_drop:
    obj.`drop`()
  of wl_data_device_selection:
    var args: (Wl_data_offer,)
    unmarshal(obj, msg, args)
    obj.`selection`(args[0])
  else:
    raise newUnknownEventError("wl_data_device", msg.opcode)

func face*(obj: Wl_data_device_manager): string =
  "wl_data_device_manager"

func version*(obj: Wl_data_device_manager): uint =
  3

proc `create_data_source`*(obj: Wl_data_device_manager; `id`: Wl_data_source) =
  request(obj, wl_data_device_manager_create_data_source, (`id`,))

proc `get_data_device`*(obj: Wl_data_device_manager; `id`: Wl_data_device;
                        `seat`: Wl_seat) =
  request(obj, wl_data_device_manager_get_data_device, (`id`, `seat`))

func face*(obj: Wl_shell): string =
  "wl_shell"

func version*(obj: Wl_shell): uint =
  1

proc `get_shell_surface`*(obj: Wl_shell; `id`: Wl_shell_surface;
                          `surface`: Wl_surface) =
  request(obj, wl_shell_get_shell_surface, (`id`, `surface`))

func face*(obj: Wl_shell_surface): string =
  "wl_shell_surface"

func version*(obj: Wl_shell_surface): uint =
  1

proc `pong`*(obj: Wl_shell_surface; `serial`: uint) =
  request(obj, wl_shell_surface_pong, (`serial`,))

proc `move`*(obj: Wl_shell_surface; `seat`: Wl_seat; `serial`: uint) =
  request(obj, wl_shell_surface_move, (`seat`, `serial`))

proc `resize`*(obj: Wl_shell_surface; `seat`: Wl_seat; `serial`: uint;
               `edges`: uint) =
  request(obj, wl_shell_surface_resize, (`seat`, `serial`, `edges`))

proc `set_toplevel`*(obj: Wl_shell_surface) =
  request(obj, wl_shell_surface_set_toplevel, ())

proc `set_transient`*(obj: Wl_shell_surface; `parent`: Wl_surface; `x`: int;
                      `y`: int; `flags`: uint) =
  request(obj, wl_shell_surface_set_transient, (`parent`, `x`, `y`, `flags`))

proc `set_fullscreen`*(obj: Wl_shell_surface; `method`: uint; `framerate`: uint;
                       `output`: Wl_output) =
  request(obj, wl_shell_surface_set_fullscreen,
          (`method`, `framerate`, `output`))

proc `set_popup`*(obj: Wl_shell_surface; `seat`: Wl_seat; `serial`: uint;
                  `parent`: Wl_surface; `x`: int; `y`: int; `flags`: uint) =
  request(obj, wl_shell_surface_set_popup,
          (`seat`, `serial`, `parent`, `x`, `y`, `flags`))

proc `set_maximized`*(obj: Wl_shell_surface; `output`: Wl_output) =
  request(obj, wl_shell_surface_set_maximized, (`output`,))

proc `set_title`*(obj: Wl_shell_surface; `title`: string) =
  request(obj, wl_shell_surface_set_title, (`title`,))

proc `set_class`*(obj: Wl_shell_surface; `class`: string) =
  request(obj, wl_shell_surface_set_class, (`class`,))

method `ping`*(obj: Wl_shell_surface; `serial`: uint) {.base.} =
  raiseAssert("wl_shell_surface.ping not implemented")

method `configure`*(obj: Wl_shell_surface; `edges`: uint; `width`: int;
                    `height`: int) {.base.} =
  raiseAssert("wl_shell_surface.configure not implemented")

method `popup_done`*(obj: Wl_shell_surface) {.base.} =
  raiseAssert("wl_shell_surface.popup_done not implemented")

method dispatchEvent*(obj: Wl_shell_surface; msg: Message) =
  case msg.opcode
  of wl_shell_surface_ping:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`ping`(args[0])
  of wl_shell_surface_configure:
    var args: (uint, int, int)
    unmarshal(obj, msg, args)
    obj.`configure`(args[0], args[1], args[2])
  of wl_shell_surface_popup_done:
    obj.`popup_done`()
  else:
    raise newUnknownEventError("wl_shell_surface", msg.opcode)

func face*(obj: Wl_surface): string =
  "wl_surface"

func version*(obj: Wl_surface): uint =
  6

proc `destroy`*(obj: Wl_surface) =
  request(obj, wl_surface_destroy, ())

proc `attach`*(obj: Wl_surface; `buffer`: Wl_buffer; `x`: int; `y`: int) =
  request(obj, wl_surface_attach, (`buffer`, `x`, `y`))

proc `damage`*(obj: Wl_surface; `x`: int; `y`: int; `width`: int; `height`: int) =
  request(obj, wl_surface_damage, (`x`, `y`, `width`, `height`))

proc `frame`*(obj: Wl_surface; `callback`: Wl_callback) =
  request(obj, wl_surface_frame, (`callback`,))

proc `set_opaque_region`*(obj: Wl_surface; `region`: Wl_region) =
  request(obj, wl_surface_set_opaque_region, (`region`,))

proc `set_input_region`*(obj: Wl_surface; `region`: Wl_region) =
  request(obj, wl_surface_set_input_region, (`region`,))

proc `commit`*(obj: Wl_surface) =
  request(obj, wl_surface_commit, ())

method `enter`*(obj: Wl_surface; `output`: Wl_output) {.base.} =
  raiseAssert("wl_surface.enter not implemented")

method `leave`*(obj: Wl_surface; `output`: Wl_output) {.base.} =
  raiseAssert("wl_surface.leave not implemented")

proc `set_buffer_transform`*(obj: Wl_surface; `transform`: int) =
  request(obj, wl_surface_set_buffer_transform, (`transform`,))

proc `set_buffer_scale`*(obj: Wl_surface; `scale`: int) =
  request(obj, wl_surface_set_buffer_scale, (`scale`,))

proc `damage_buffer`*(obj: Wl_surface; `x`: int; `y`: int; `width`: int;
                      `height`: int) =
  request(obj, wl_surface_damage_buffer, (`x`, `y`, `width`, `height`))

proc `offset`*(obj: Wl_surface; `x`: int; `y`: int) =
  request(obj, wl_surface_offset, (`x`, `y`))

method `preferred_buffer_scale`*(obj: Wl_surface; `factor`: int) {.base.} =
  raiseAssert("wl_surface.preferred_buffer_scale not implemented")

method `preferred_buffer_transform`*(obj: Wl_surface; `transform`: uint) {.base.} =
  raiseAssert("wl_surface.preferred_buffer_transform not implemented")

method dispatchEvent*(obj: Wl_surface; msg: Message) =
  case msg.opcode
  of wl_surface_enter:
    var args: (Wl_output,)
    unmarshal(obj, msg, args)
    obj.`enter`(args[0])
  of wl_surface_leave:
    var args: (Wl_output,)
    unmarshal(obj, msg, args)
    obj.`leave`(args[0])
  of wl_surface_preferred_buffer_scale:
    var args: (int,)
    unmarshal(obj, msg, args)
    obj.`preferred_buffer_scale`(args[0])
  of wl_surface_preferred_buffer_transform:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`preferred_buffer_transform`(args[0])
  else:
    raise newUnknownEventError("wl_surface", msg.opcode)

func face*(obj: Wl_seat): string =
  "wl_seat"

func version*(obj: Wl_seat): uint =
  9

method `capabilities`*(obj: Wl_seat; `capabilities`: uint) {.base.} =
  raiseAssert("wl_seat.capabilities not implemented")

proc `get_pointer`*(obj: Wl_seat; `id`: Wl_pointer) =
  request(obj, wl_seat_get_pointer, (`id`,))

proc `get_keyboard`*(obj: Wl_seat; `id`: Wl_keyboard) =
  request(obj, wl_seat_get_keyboard, (`id`,))

proc `get_touch`*(obj: Wl_seat; `id`: Wl_touch) =
  request(obj, wl_seat_get_touch, (`id`,))

method `name`*(obj: Wl_seat; `name`: string) {.base.} =
  raiseAssert("wl_seat.name not implemented")

proc `release`*(obj: Wl_seat) =
  request(obj, wl_seat_release, ())

method dispatchEvent*(obj: Wl_seat; msg: Message) =
  case msg.opcode
  of wl_seat_capabilities:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`capabilities`(args[0])
  of wl_seat_name:
    var args: (string,)
    unmarshal(obj, msg, args)
    obj.`name`(args[0])
  else:
    raise newUnknownEventError("wl_seat", msg.opcode)

func face*(obj: Wl_pointer): string =
  "wl_pointer"

func version*(obj: Wl_pointer): uint =
  9

proc `set_cursor`*(obj: Wl_pointer; `serial`: uint; `surface`: Wl_surface;
                   `hotspot_x`: int; `hotspot_y`: int) =
  request(obj, wl_pointer_set_cursor,
          (`serial`, `surface`, `hotspot_x`, `hotspot_y`))

method `enter`*(obj: Wl_pointer; `serial`: uint; `surface`: Wl_surface;
                `surface_x`: SignedDecimal; `surface_y`: SignedDecimal) {.base.} =
  raiseAssert("wl_pointer.enter not implemented")

method `leave`*(obj: Wl_pointer; `serial`: uint; `surface`: Wl_surface) {.base.} =
  raiseAssert("wl_pointer.leave not implemented")

method `motion`*(obj: Wl_pointer; `time`: uint; `surface_x`: SignedDecimal;
                 `surface_y`: SignedDecimal) {.base.} =
  raiseAssert("wl_pointer.motion not implemented")

method `button`*(obj: Wl_pointer; `serial`: uint; `time`: uint; `button`: uint;
                 `state`: uint) {.base.} =
  raiseAssert("wl_pointer.button not implemented")

method `axis`*(obj: Wl_pointer; `time`: uint; `axis`: uint;
               `value`: SignedDecimal) {.base.} =
  raiseAssert("wl_pointer.axis not implemented")

proc `release`*(obj: Wl_pointer) =
  request(obj, wl_pointer_release, ())

method `frame`*(obj: Wl_pointer) {.base.} =
  raiseAssert("wl_pointer.frame not implemented")

method `axis_source`*(obj: Wl_pointer; `axis_source`: uint) {.base.} =
  raiseAssert("wl_pointer.axis_source not implemented")

method `axis_stop`*(obj: Wl_pointer; `time`: uint; `axis`: uint) {.base.} =
  raiseAssert("wl_pointer.axis_stop not implemented")

method `axis_discrete`*(obj: Wl_pointer; `axis`: uint; `discrete`: int) {.base.} =
  raiseAssert("wl_pointer.axis_discrete not implemented")

method `axis_value120`*(obj: Wl_pointer; `axis`: uint; `value120`: int) {.base.} =
  raiseAssert("wl_pointer.axis_value120 not implemented")

method `axis_relative_direction`*(obj: Wl_pointer; `axis`: uint;
                                  `direction`: uint) {.base.} =
  raiseAssert("wl_pointer.axis_relative_direction not implemented")

method dispatchEvent*(obj: Wl_pointer; msg: Message) =
  case msg.opcode
  of wl_pointer_enter:
    var args: (uint, Wl_surface, SignedDecimal, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`enter`(args[0], args[1], args[2], args[3])
  of wl_pointer_leave:
    var args: (uint, Wl_surface)
    unmarshal(obj, msg, args)
    obj.`leave`(args[0], args[1])
  of wl_pointer_motion:
    var args: (uint, SignedDecimal, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`motion`(args[0], args[1], args[2])
  of wl_pointer_button:
    var args: (uint, uint, uint, uint)
    unmarshal(obj, msg, args)
    obj.`button`(args[0], args[1], args[2], args[3])
  of wl_pointer_axis:
    var args: (uint, uint, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`axis`(args[0], args[1], args[2])
  of wl_pointer_frame:
    obj.`frame`()
  of wl_pointer_axis_source:
    var args: (uint,)
    unmarshal(obj, msg, args)
    obj.`axis_source`(args[0])
  of wl_pointer_axis_stop:
    var args: (uint, uint)
    unmarshal(obj, msg, args)
    obj.`axis_stop`(args[0], args[1])
  of wl_pointer_axis_discrete:
    var args: (uint, int)
    unmarshal(obj, msg, args)
    obj.`axis_discrete`(args[0], args[1])
  of wl_pointer_axis_value120:
    var args: (uint, int)
    unmarshal(obj, msg, args)
    obj.`axis_value120`(args[0], args[1])
  of wl_pointer_axis_relative_direction:
    var args: (uint, uint)
    unmarshal(obj, msg, args)
    obj.`axis_relative_direction`(args[0], args[1])
  else:
    raise newUnknownEventError("wl_pointer", msg.opcode)

func face*(obj: Wl_keyboard): string =
  "wl_keyboard"

func version*(obj: Wl_keyboard): uint =
  9

method `keymap`*(obj: Wl_keyboard; `format`: uint; `fd`: cint; `size`: uint) {.
    base.} =
  raiseAssert("wl_keyboard.keymap not implemented")

method `enter`*(obj: Wl_keyboard; `serial`: uint; `surface`: Wl_surface;
                `keys`: seq[uint32]) {.base.} =
  raiseAssert("wl_keyboard.enter not implemented")

method `leave`*(obj: Wl_keyboard; `serial`: uint; `surface`: Wl_surface) {.base.} =
  raiseAssert("wl_keyboard.leave not implemented")

method `key`*(obj: Wl_keyboard; `serial`: uint; `time`: uint; `key`: uint;
              `state`: uint) {.base.} =
  raiseAssert("wl_keyboard.key not implemented")

method `modifiers`*(obj: Wl_keyboard; `serial`: uint; `mods_depressed`: uint;
                    `mods_latched`: uint; `mods_locked`: uint; `group`: uint) {.
    base.} =
  raiseAssert("wl_keyboard.modifiers not implemented")

proc `release`*(obj: Wl_keyboard) =
  request(obj, wl_keyboard_release, ())

method `repeat_info`*(obj: Wl_keyboard; `rate`: int; `delay`: int) {.base.} =
  raiseAssert("wl_keyboard.repeat_info not implemented")

method dispatchEvent*(obj: Wl_keyboard; msg: Message) =
  case msg.opcode
  of wl_keyboard_keymap:
    var args: (uint, cint, uint)
    unmarshal(obj, msg, args)
    obj.`keymap`(args[0], args[1], args[2])
  of wl_keyboard_enter:
    var args: (uint, Wl_surface, seq[uint32])
    unmarshal(obj, msg, args)
    obj.`enter`(args[0], args[1], args[2])
  of wl_keyboard_leave:
    var args: (uint, Wl_surface)
    unmarshal(obj, msg, args)
    obj.`leave`(args[0], args[1])
  of wl_keyboard_key:
    var args: (uint, uint, uint, uint)
    unmarshal(obj, msg, args)
    obj.`key`(args[0], args[1], args[2], args[3])
  of wl_keyboard_modifiers:
    var args: (uint, uint, uint, uint, uint)
    unmarshal(obj, msg, args)
    obj.`modifiers`(args[0], args[1], args[2], args[3], args[4])
  of wl_keyboard_repeat_info:
    var args: (int, int)
    unmarshal(obj, msg, args)
    obj.`repeat_info`(args[0], args[1])
  else:
    raise newUnknownEventError("wl_keyboard", msg.opcode)

func face*(obj: Wl_touch): string =
  "wl_touch"

func version*(obj: Wl_touch): uint =
  9

method `down`*(obj: Wl_touch; `serial`: uint; `time`: uint;
               `surface`: Wl_surface; `id`: int; `x`: SignedDecimal;
               `y`: SignedDecimal) {.base.} =
  raiseAssert("wl_touch.down not implemented")

method `up`*(obj: Wl_touch; `serial`: uint; `time`: uint; `id`: int) {.base.} =
  raiseAssert("wl_touch.up not implemented")

method `motion`*(obj: Wl_touch; `time`: uint; `id`: int; `x`: SignedDecimal;
                 `y`: SignedDecimal) {.base.} =
  raiseAssert("wl_touch.motion not implemented")

method `frame`*(obj: Wl_touch) {.base.} =
  raiseAssert("wl_touch.frame not implemented")

method `cancel`*(obj: Wl_touch) {.base.} =
  raiseAssert("wl_touch.cancel not implemented")

proc `release`*(obj: Wl_touch) =
  request(obj, wl_touch_release, ())

method `shape`*(obj: Wl_touch; `id`: int; `major`: SignedDecimal;
                `minor`: SignedDecimal) {.base.} =
  raiseAssert("wl_touch.shape not implemented")

method `orientation`*(obj: Wl_touch; `id`: int; `orientation`: SignedDecimal) {.
    base.} =
  raiseAssert("wl_touch.orientation not implemented")

method dispatchEvent*(obj: Wl_touch; msg: Message) =
  case msg.opcode
  of wl_touch_down:
    var args: (uint, uint, Wl_surface, int, SignedDecimal, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`down`(args[0], args[1], args[2], args[3], args[4], args[5])
  of wl_touch_up:
    var args: (uint, uint, int)
    unmarshal(obj, msg, args)
    obj.`up`(args[0], args[1], args[2])
  of wl_touch_motion:
    var args: (uint, int, SignedDecimal, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`motion`(args[0], args[1], args[2], args[3])
  of wl_touch_frame:
    obj.`frame`()
  of wl_touch_cancel:
    obj.`cancel`()
  of wl_touch_shape:
    var args: (int, SignedDecimal, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`shape`(args[0], args[1], args[2])
  of wl_touch_orientation:
    var args: (int, SignedDecimal)
    unmarshal(obj, msg, args)
    obj.`orientation`(args[0], args[1])
  else:
    raise newUnknownEventError("wl_touch", msg.opcode)

func face*(obj: Wl_output): string =
  "wl_output"

func version*(obj: Wl_output): uint =
  4

method `geometry`*(obj: Wl_output; `x`: int; `y`: int; `physical_width`: int;
                   `physical_height`: int; `subpixel`: int; `make`: string;
                   `model`: string; `transform`: int) {.base.} =
  raiseAssert("wl_output.geometry not implemented")

method `mode`*(obj: Wl_output; `flags`: uint; `width`: int; `height`: int;
               `refresh`: int) {.base.} =
  raiseAssert("wl_output.mode not implemented")

method `done`*(obj: Wl_output) {.base.} =
  raiseAssert("wl_output.done not implemented")

method `scale`*(obj: Wl_output; `factor`: int) {.base.} =
  raiseAssert("wl_output.scale not implemented")

proc `release`*(obj: Wl_output) =
  request(obj, wl_output_release, ())

method `name`*(obj: Wl_output; `name`: string) {.base.} =
  raiseAssert("wl_output.name not implemented")

method `description`*(obj: Wl_output; `description`: string) {.base.} =
  raiseAssert("wl_output.description not implemented")

method dispatchEvent*(obj: Wl_output; msg: Message) =
  case msg.opcode
  of wl_output_geometry:
    var args: (int, int, int, int, int, string, string, int)
    unmarshal(obj, msg, args)
    obj.`geometry`(args[0], args[1], args[2], args[3], args[4], args[5],
                   args[6], args[7])
  of wl_output_mode:
    var args: (uint, int, int, int)
    unmarshal(obj, msg, args)
    obj.`mode`(args[0], args[1], args[2], args[3])
  of wl_output_done:
    obj.`done`()
  of wl_output_scale:
    var args: (int,)
    unmarshal(obj, msg, args)
    obj.`scale`(args[0])
  of wl_output_name:
    var args: (string,)
    unmarshal(obj, msg, args)
    obj.`name`(args[0])
  of wl_output_description:
    var args: (string,)
    unmarshal(obj, msg, args)
    obj.`description`(args[0])
  else:
    raise newUnknownEventError("wl_output", msg.opcode)

func face*(obj: Wl_region): string =
  "wl_region"

func version*(obj: Wl_region): uint =
  1

proc `destroy`*(obj: Wl_region) =
  request(obj, wl_region_destroy, ())

proc `add`*(obj: Wl_region; `x`: int; `y`: int; `width`: int; `height`: int) =
  request(obj, wl_region_add, (`x`, `y`, `width`, `height`))

proc `subtract`*(obj: Wl_region; `x`: int; `y`: int; `width`: int; `height`: int) =
  request(obj, wl_region_subtract, (`x`, `y`, `width`, `height`))

func face*(obj: Wl_subcompositor): string =
  "wl_subcompositor"

func version*(obj: Wl_subcompositor): uint =
  1

proc `destroy`*(obj: Wl_subcompositor) =
  request(obj, wl_subcompositor_destroy, ())

proc `get_subsurface`*(obj: Wl_subcompositor; `id`: Wl_subsurface;
                       `surface`: Wl_surface; `parent`: Wl_surface) =
  request(obj, wl_subcompositor_get_subsurface, (`id`, `surface`, `parent`))

func face*(obj: Wl_subsurface): string =
  "wl_subsurface"

func version*(obj: Wl_subsurface): uint =
  1

proc `destroy`*(obj: Wl_subsurface) =
  request(obj, wl_subsurface_destroy, ())

proc `set_position`*(obj: Wl_subsurface; `x`: int; `y`: int) =
  request(obj, wl_subsurface_set_position, (`x`, `y`))

proc `place_above`*(obj: Wl_subsurface; `sibling`: Wl_surface) =
  request(obj, wl_subsurface_place_above, (`sibling`,))

proc `place_below`*(obj: Wl_subsurface; `sibling`: Wl_surface) =
  request(obj, wl_subsurface_place_below, (`sibling`,))

proc `set_sync`*(obj: Wl_subsurface) =
  request(obj, wl_subsurface_set_sync, ())

proc `set_desync`*(obj: Wl_subsurface) =
  request(obj, wl_subsurface_set_desync, ())

