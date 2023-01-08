class_name Menu extends Control

var menu_stack = []
var disabled = false

func _unhandled_input(event):
	if not disabled and event.is_action_pressed("ui_cancel"):
		if menu_stack.size() > 1:
			menu_stack.pop_back()
			update_menu()
			get_tree().set_input_as_handled()


func append_menu(m):
	menu_stack.append(m)
	update_menu()

func clear_menu():
	menu_stack = []
	update_menu()

func update_menu():
	for child in get_children():
		child.hide()
	
	if menu_stack.size() > 0:
		menu_stack[menu_stack.size() - 1].show()
