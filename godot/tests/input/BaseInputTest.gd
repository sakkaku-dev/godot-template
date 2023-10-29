class_name BaseInputTest extends UnitTest


func mouse_button_event(button: int, position: Vector2, pressed = true) -> InputEvent:
	var mouse = InputEventMouseButton.new()
	mouse.button_index = button
	mouse.pressed = pressed
	mouse.position = position
	mouse.global_position = position
	return mouse


func press_key(input: String, strength = 0) -> InputEvent:
	return _create_input(input, strength, true)


func release_key(input: String) -> InputEvent:
	return _create_input(input, 0, false)


func _create_input(input: String, strength = 0, pressed = true) -> InputEvent:
	var ev = InputEventAction.new()
	ev.action = input
	ev.pressed = pressed
	ev.strength = strength
	return ev


func joypad_motion_event(axis: int, value: float) -> InputEvent:
	var joy = InputEventJoypadMotion.new()
	joy.axis = axis
	joy.axis_value = value
	return joy
