class_name InputReader
extends Node

signal disabled(disable)
signal just_pressed(ev: InputEvent)
signal just_released(ev: InputEvent)

var input_types = InputMap.get_actions()

var inputs = []
var action_strength = {}
var _disabled = false : set = _set_disabled
var disabled_exception = []


func _set_disabled(d):
	_disabled = d
	emit_signal("disabled", d)


func handle_input(event: InputEvent):
	var actions = _get_actions_for_event(event)

	for action in actions:
		if _disabled and not action in disabled_exception:
			continue

		action_strength[action] = event.get_action_strength(action)
		_register_action(event, action)


func _register_action(event: InputEvent, action: String):
	if event.is_action_pressed(action):
		if not inputs.has(action):
			inputs.append(action)
		emit_signal("just_pressed", event)
	if event.is_action_released(action):
		inputs.erase(action)
		emit_signal("just_released", event)


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


func get_action_strength(key: String) -> float:
	if action_strength.has(key):
		return action_strength[key]

	return 0.0


func disable(exceptions: Array = []) -> void:
	self._disabled = true
	reset()
	disabled_exception = exceptions


func enable() -> void:
	self._disabled = false
	disabled_exception = []

func reset() -> void:
	inputs.clear()
	action_strength.clear()
