extends Node

signal scene_changed()

const DEFAULT_SPEED = 2

@export var disable_inputs = true

@onready var anim := $AnimationPlayer

var transitioning = false

func _input(event):
	if transitioning:
		get_tree().set_input_as_handled()


func reload_scene():
	change_scene(get_tree().current_scene.filename)


func change_scene(scene):
	var path = scene
	if scene is PackedScene:
		path = scene.resource_path
	transitioning = true
	
	await _play_transition(DEFAULT_SPEED, false)
	get_tree().change_scene(path)
	await _play_transition(DEFAULT_SPEED, true)

	transitioning = false
	emit_signal("scene_changed")


func _play_transition(speed: float, backwards: bool):
	anim.playback_speed = speed
	if backwards:
		anim.play_backwards("Transition")
	else:
		anim.play("Transition")
	await anim.animation_finished
