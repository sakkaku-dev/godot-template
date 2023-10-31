class_name Spawner2D
extends Node2D

@export var autostart := false
@export var scene: PackedScene
@export var offset := 0

func _ready():
	if autostart:
		spawn()

func spawn():
	return _create()

func _create(offset_dir = offset * Vector2.RIGHT.rotated(global_rotation)):
	var eff = scene.instantiate()
	eff.global_position = global_position + offset_dir
	eff.global_rotation = global_rotation
	get_tree().current_scene.add_child(eff)
	return eff
