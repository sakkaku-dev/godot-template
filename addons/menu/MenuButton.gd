extends Button

export var menu_path: NodePath
onready var menu: Control = get_node(menu_path) if menu_path else null

func _ready():
	if menu:
		connect("pressed", self, "_on_MenuButton_pressed")


func _on_MenuButton_pressed():
	menu.show()
