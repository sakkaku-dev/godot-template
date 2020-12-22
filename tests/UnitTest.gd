extends "res://addons/gut/test.gd"

class_name UnitTest


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
