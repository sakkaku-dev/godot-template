extends Node

class_name MouseFollowState

export var follow = false

export var body_path: NodePath
onready var body: Node2D = get_node(body_path)


func _physics_process(delta):
	if follow:
		var pos = body.get_global_mouse_position()
		if _is_inside_viewport(pos):
			body.global_position = body.global_position.move_toward(pos, 1000)
		
func _is_inside_viewport(pos: Vector2):
	return get_viewport().get_visible_rect().has_point(pos)
