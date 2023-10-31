class_name TargetController
extends CharacterController

@export var node: Node2D

func get_motion():
	return global_position.direction_to(node.global_position)
