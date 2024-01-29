class_name FreeOnExit
extends VisibleOnScreenNotifier2D

@export var node: Node

func _ready():
	if node:
		screen_exited.connect(func(): node.queue_free())
