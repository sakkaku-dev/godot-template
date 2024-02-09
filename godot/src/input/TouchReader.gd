class_name TouchReader
extends Node

signal swipe(left)

@export var swipe_threshold = 100

var swipe_start


func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				swipe_start = event.position
			else:
				_calculate_swipe(event.position)
				swipe_start = null


func _calculate_swipe(swipe_end):
	if swipe_start == null:
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > swipe_threshold:
		if swipe.x > 0:
			emit_signal("swipe", false)
		else:
			emit_signal("swipe", true)
