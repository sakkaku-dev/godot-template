extends Control

class_name FocusContainer

export var init_focus_path: NodePath
onready var init_focus := get_node(init_focus_path) if init_focus_path else null

func _ready():
	for child in get_children():
		if child is Focusable:
			child.connect("focused", self, "_unfocus_all", [child])

func _unfocus_all(node: Focusable) -> void:
	for child in get_children():
		if child is Focusable and child != node:
			child.unfocus()

func show():
	.show()
	
	if init_focus:
		_focus_node(init_focus)
	elif get_child_count() > 0:
		var child = get_child(0)
		_focus_node(child)

func _focus_node(node: Control) -> void:
	node.show()
	
	if node is Focusable:
		node.focus()
	else:
		node.grab_focus()
