class_name DeviceSwitcher
extends Node

@export var input: PlayerInput

var logger = Logger.new("DeviceSwitcher")

func _unhandled_input(event: InputEvent):
	if input == null or input.is_player_event(event):
		return
		
	if event is InputEventMouseMotion or event is InputEventAction:
		return

	# motion has some small flickering
	var joypad = event is InputEventJoypadButton or (event is InputEventJoypadMotion and event.axis_value > 0.7)
	if input.joypad != joypad:
		input.joypad = joypad
