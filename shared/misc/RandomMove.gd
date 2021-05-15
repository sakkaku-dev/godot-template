extends Node2D

class_name RandomMove

export(Array, NodePath) var node_path: Array

onready var collision := $CollisionShape2D

var nodes = []

func _ready():
	for path in node_path:
		var node = get_node(path)
		nodes.append(node)
		move(node)

func move_idx(idx):
	if idx >= 0 and idx < nodes.size():
		move(nodes[idx])

func move(node):
	var rect_shape = collision.shape as RectangleShape2D
	var rand_local_pos = Vector2(
		Random.random_int(0, rect_shape.extents.x * 2),
		Random.random_int(0, rect_shape.extents.y * 2)
	)
	var start_pos = collision.global_position
	start_pos.x -= rect_shape.extents.x
	start_pos.y -= rect_shape.extents.y
	
	node.global_position = start_pos + rand_local_pos
