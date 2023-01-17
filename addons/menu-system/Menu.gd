class_name Menu extends Control

var menu_stack = []

func _unhandled_input(event: InputEvent):
	_handle_event(event)

func _handle_event(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		if is_in_sub_menu():
			menu_stack.pop_back()
			update_menu()
			get_tree().set_input_as_handled()

func is_menu_visible():
	return menu_stack.size() > 0
	
func is_in_sub_menu():
	return menu_stack.size() > 1

func change_menu(m):
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

