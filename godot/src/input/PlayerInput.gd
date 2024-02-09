class_name PlayerInput
extends InputReader

signal device_switched()

const Device = {
	KEYBOARD = "Keyboard",
	PLAYSTATION = "PS",
	XBOX = "XBOX",
	STEAM_DECK = "Deck",
}

@export var joypad = false : set = _set_joypad
@export var device_id = 0

var _device := Device.KEYBOARD
var _logger = Logger.new()

func _set_joypad(is_joypad: bool):
	joypad = is_joypad
	
	if joypad:
		_device = _get_simplified_device(Input.get_joy_name(device_id))
	else:
		_device = Device.KEYBOARD
	
	_logger.debug("Changing device %s to joypad %s and device type %s" % [device_id, joypad, _device])
	device_switched.emit()

func _get_simplified_device(raw_name: String) -> String:
	logger.debug("Detecting controller type from name: %s" % raw_name)

	var n = raw_name.to_lower()
	if n.contains("xbox") or n.contains("microsoft"):
		return Device.XBOX
	
	if n.contains("ps4") or n.contains("ps5") or n.contains("sony") or n.contains("dualsense") or n.contains("dualshock"):
		return Device.PLAYSTATION
	
	return Device.STEAM_DECK

func is_player_event(event: InputEvent) -> bool:
	return joypad == _is_joypad_event(event) and device_id == event.device


func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion


func _unhandled_input(event):
	handle_input(event)


func handle_input(event: InputEvent) -> void:
	if not is_player_event(event):
		return

	super.handle_input(event)
