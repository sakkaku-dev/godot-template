extends Node

signal scene_changed()

const DEFAULT_SPEED = 2

export var disable_inputs = true

onready var anim := $AnimationPlayer

var transitioning = false

func _input(event):
	if transitioning:
		get_tree().set_input_as_handled()

func change_scene(scene: PackedScene):
	transitioning = true
	
	yield(_play_transition(DEFAULT_SPEED, false), "completed")
	get_tree().change_scene_to(scene)
	yield(_play_transition(DEFAULT_SPEED, true), "completed")

	transitioning = false
	emit_signal("scene_changed")

func _play_transition(speed: float, backwards: bool):
	anim.playback_speed = speed
	if backwards:
		anim.play_backwards("Transition")
	else:
		anim.play("Transition")
	yield(anim, "animation_finished")
