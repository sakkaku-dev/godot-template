class_name Effect
extends Node

signal finished()

@export var delay = 0.0
@export var duration = 0.5
@export var reverse = false
@export var loop = false
@export var autostart = true

@export var transition = Tween.TRANS_LINEAR
@export var ease_type = Tween.EASE_IN_OUT

@export var property: String

@onready var node = get_parent() if obj == null else obj

var obj
var tween: Tween
var start_value = null
var end_value = null


func _ready():
	if start_value == null:
		start_value = node.get(property)
	
	if autostart:
		start()

func setup_props(prop: String, start_v, end_v):
	property = prop
	start_value = start_v
	end_value = end_v

# deprecated: directly set the fields
func setup():
	_interpolate_node()


# deprecated: directly set the fields
func _interpolate(prop: String, end_v, start_v = prop):
	setup_props(prop, start_v, end_v)
	_interpolate_node()

func _interpolate_node():
	var init_start = node.get(start_value) if start_value is String else start_value
	var init_end = node.get(end_value) if end_value is String else end_value

	var s = init_end if reverse else init_start
	var e = init_start if reverse else init_end

	tween.tween_property(node, property, e, duration) \
		.from(s) \
		.set_delay(delay) \
		.set_ease(ease_type) \
		.set_trans(transition)

	node.set(property, s)


func finish():
	tween.pause()
	tween.custom_step(delay + duration)


func start():
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
