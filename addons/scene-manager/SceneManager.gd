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

const DEFAULT_SPEED = 1

@export var disable_inputs = true

@onready var rect: ColorRect = $CanvasLayer/ColorRect

var transitioning = false

func _input(event):
	if transitioning:
		get_viewport().set_input_as_handled()


func reload_scene():
	change_scene(get_tree().current_scene.filename)


func change_scene(scene, transition = null, speed = DEFAULT_SPEED):
	var path = scene
	if scene is PackedScene:
		path = scene.resource_path
	transitioning = true
	
	await _fade(false, transition, speed)
	get_tree().change_scene_to_file(path)
	await _fade(true, transition, speed)

	transitioning = false
	emit_signal("scene_changed")


func _fade(reverse: bool, transition, speed: float):
	var eff = Effect.new()
	var start = 1.0 if reverse else 0.0
	var end = 0.0 if reverse else 1.0
	eff.setup_props("shader_parameter/dissolve_amount", start, end)
	var mat: ShaderMaterial = rect.get_material()
	if transition:
		mat.set("shader_parameter/dissolve_texture", load(SHADER_DIR + "/" + TRANSITION_MAP[transition]))
	mat.set("shader_parameter/fade", transition == null)
	eff.obj = mat
	
	eff.duration = speed
	add_child(eff)
	await eff.finished
