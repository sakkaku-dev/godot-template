class_name PlayerInput extends InputReader

export var joypad = false
export var device_id = 0


func is_player_event(event: InputEvent) -> bool:
	return joypad == _is_joypad_event(event) and device_id == event.device


func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion

func get_id() -> String:
	return "%s#%s#%s" % [get_network_master(), device_id, joypad]

func _unhandled_input(event):
	handle_input(event)


func handle_input(event: InputEvent) -> void:
	if not is_player_event(event):
		return
	
	.handle_input(event)
