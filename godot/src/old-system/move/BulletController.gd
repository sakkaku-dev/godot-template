class_name BulletController
extends CharacterController

@export var dir := Vector2.RIGHT

func get_motion():
	return dir
