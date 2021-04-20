extends Node

"""
Reads InputEvents and tracks which inputs are pressed for all devices
"""

class_name InputReader

var input_types = InputMap.get_actions()

var just_pressed = []
var inputs = []
var action_strength = {}


func handle_input(event: InputEvent):
	_update_action_strength(event)

	var actions = _get_actions_for_event(event)
	
	for action in actions:
		_register_action(event, action)


func _register_action(event: InputEvent, action: String):
	if event.is_action_pressed(action):
		if not inputs.has(action):
			inputs.append(action)
		if not just_pressed.has(action):
			just_pressed.append(action)
	if event.is_action_released(action):
		if inputs.has(action):
			inputs.erase(action)


func _process(_delta):
	just_pressed = []


func _update_action_strength(event: InputEvent) -> void:
	for k in input_types:
		if event.is_action(k):
			action_strength[k] = event.get_action_strength(k)


func _get_actions_for_event(event: InputEvent) -> Array:
	var actions = []
	for action in input_types:
		if event.is_action(action):
			actions.append(action)

	return actions


func is_pressed_any(keys: Array) -> bool:
	for k in keys:
		if inputs.has(k):
			return true
	return false


func is_pressed(key: String) -> bool:
	return inputs.has(key)


func is_just_pressed(key: String) -> bool:
	return just_pressed.has(key)


func get_action_strength(key: String) -> float:
	if action_strength.has(key):
		return action_strength[key]

	return 0.0
