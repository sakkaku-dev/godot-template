class_name Interactable
extends Area2D

signal interacted

const OUTLINE = preload("res://shared/items/sprite_outline.tres")

@export var sprite: Sprite2D

func _ready():
	sprite.material = OUTLINE

func highlight():
	var mat = sprite.material as ShaderMaterial
	mat.set_shader_parameter("enable", true)


func unhighlight():
	var mat = sprite.material as ShaderMaterial
	mat.set_shader_parameter("enable", false)


func interact():
	interacted.emit()
