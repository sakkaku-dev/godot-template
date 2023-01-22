extends CanvasLayer

@onready var options := $CenterContainer/VBoxContainer/OptionButton
@onready var version := $CenterContainer/VBoxContainer/Version


func _ready():
	version.text = Env.version

	for lvl in Env.Level.keys():
		options.add_item(lvl)
	options.selected = Env.log_level


func _on_OptionButton_item_selected(index: int):
	Env.log_level = index
