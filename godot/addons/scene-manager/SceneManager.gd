extends Node

signal scene_changed()

enum Transition {
	FULL,
	CIRCLE,
	CURTAIN_H,
	CURTAIN_V,
	DIAGONAL,
	DIAGONAL_SQUARE,
	HORIZONTAL,
	VERTICAL,
	SCRIBBLES,
	RADIAL,
}

const ROOT_DIR = "res://addons/scene-manager"
const SHADER_DIR = ROOT_DIR + "/shader_patterns"
const TRANSITION_MAP = {
	Transition.FULL: "full.png",
	Transition.CIRCLE: "circle.png",
	Transition.CURTAIN_H: "curtains_h.png",
	Transition.CURTAIN_V: "curtains.png",
	Transition.DIAGONAL: "diagonal.png",
	Transition.DIAGONAL_SQUARE: "squares.png",
	Transition.HORIZONTAL: "horizontal.png",
	Transition.VERTICAL: "vertical.png",
	Transition.SCRIBBLES: "scribbles.png",
	Transition.RADIAL: "radial.png",
}

const DEFAULT_SPEED = 1.5

@export var disable_inputs = true

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var rect: ColorRect = $CanvasLayer/ColorRect

var transitioning = false

func _input(event):
	if transitioning:
		get_viewport().set_input_as_handled()


func reload_scene():
	change_scene(get_tree().current_scene.scene_file_path)


func change_scene(scene, transition = null, speed = DEFAULT_SPEED):
	var path = scene
	if scene is PackedScene:
		path = scene.resource_path
	transitioning = true
	
	anim.play("fade_out", -1, speed)
	await anim.animation_finished

	get_tree().change_scene_to_file(path)

	anim.play("fade_in", -1, speed)
	transitioning = false
	await anim.animation_finished

	scene_changed.emit()