extends Control

class_name Menu

export var back_menu_path: NodePath
onready var back_menu := get_node(back_menu_path) if back_menu_path else null



func show():
	.show()
	
	if get_child_count() > 0:
		var child = get_child(0)
		child.show()
		child.grab_focus()

func go_back():
	if not back_menu: return
	back_menu.show()

func _unhandled_input(event):
	if visible and event.is_action("ui_cancel"):
		go_back()
