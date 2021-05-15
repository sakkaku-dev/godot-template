extends VisibilityNotifier2D

export var enabled = true

export var obj_path: NodePath
onready var obj: Node = get_node(obj_path)

func _on_FreeOnExit_screen_exited():
	if enabled:
		obj.queue_free()


func _on_Timer_timeout():
	if not is_on_screen():
		obj.queue_free()
