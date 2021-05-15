extends State

class_name MoveForwardState

export var move = true

export var speed = 100
export var backwards = false

export var body_path: NodePath
onready var body: Node2D = get_node(body_path)

func _physics_process(delta):
	if move:
		var dir = 1 if backwards else -1
		body.move_local_y(dir * speed * delta)
