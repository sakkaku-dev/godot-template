extends FocusContainer

class_name Menu

export var init_show = false

export var back_menu_path: NodePath
onready var back_menu := get_node(back_menu_path) if back_menu_path else null

func _ready():
	if init_show:
		show()


func go_back():
	if not back_menu: return
	back_menu.show()

func _unhandled_input(event):
	if visible and event.is_action("ui_cancel"):
		go_back()
