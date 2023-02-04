class_name Effect
extends Node

signal finished()

@export var delay = 0.0
@export var duration = 0.5
@export var reverse = true
@export var loop = false

@export var transition = Tween.TRANS_LINEAR
@export var ease_type = Tween.EASE_IN_OUT
var tween: Tween

func _ready():
	_create_tween()

func _create_tween():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	setup()
	tween.play()
	tween.finished.connect(_on_tween_completed)

func _on_tween_completed():
	if loop:
		reverse = not reverse
		_create_tween()
	else:
		finished.emit()
		queue_free()


func _interpolate_node(node: Node, property: String, start_value, end_value):
	var start = node.get(start_value) if start_value is String else start_value
	var end = node.get(end_value) if end_value is String else end_value

	tween.tween_property(node, property, end, duration) \
		.from(start) \
		.set_delay(delay) \
		.set_ease(ease_type) \
		.set_trans(transition)

	node.set(property, start)

func _interpolate(property: String, end_value, start_value = property):
	var node = get_parent()
	if reverse:
		_interpolate_node(node, property, end_value, start_value)
	else:
		_interpolate_node(node, property, start_value, end_value)

func setup():
	pass
