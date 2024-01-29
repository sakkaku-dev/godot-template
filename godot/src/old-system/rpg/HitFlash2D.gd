class_name HitFlash2D
extends Node

@export var time := 0.1
@export var node: Node2D

func flash():
	if node and node.material:
		var mat = node.material as ShaderMaterial
		_set_hit_flash(mat, true)
		await get_tree().create_timer(time).timeout
		_set_hit_flash(mat, false)

func reset():
	if node:
		_set_hit_flash(node.material, false)

func _set_hit_flash(mat: ShaderMaterial, enable: bool):
	pass
