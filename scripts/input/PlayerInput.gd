extends InputReader

"""
Input Reader for a single player
"""

class_name PlayerInput

var joypad_input = false
var device_id = 0

func _init(device = 0, joypad = false):
	self.device_id = device
	self.joypad_input = joypad


func is_player_event(event: InputEvent) -> bool:
	return joypad_input == _is_joypad_event(event) and device_id == event.device


func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion


func get_unique_name() -> String:
	return str(get_network_master()) + ":" + str(device_id) + ":" + str(joypad_input)


func handle_input(event: InputEvent) -> void:
	if not is_player_event(event):
		return
	
	.handle_input(event)

func get_move_vector() -> Vector2:
	return Vector2(get_action_strength(MOVE_RIGHT) - get_action_strength(MOVE_LEFT), 0)
