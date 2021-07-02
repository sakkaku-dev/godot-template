extends Control

class_name Menu

export var init_focus_path: NodePath
onready var init_focus := get_node(init_focus_path) if init_focus_path else null

export var back_menu_path: NodePath
onready var back_menu := get_node(back_menu_path) if back_menu_path else null


func show():
	.show()
	
	if init_focus:
		_focus_node(init_focus)
	elif get_child_count() > 0:
		var child = get_child(0)
		_focus_node(child)

func _focus_node(node: Control) -> void:
	node.show()
	node.grab_focus()

func go_back():
	if not back_menu: return
	back_menu.show()

func _unhandled_input(event):
	if visible and event.is_action("ui_cancel"):
		go_back()
