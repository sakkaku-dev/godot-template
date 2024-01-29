class_name FrameFreeze
extends Node

@export var time_scale := 0.05
@export var duration := 0.5

func freeze():
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1
