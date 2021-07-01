extends MenuContainer

signal start_game

onready var exit_btn := $MainMenu/Exit

func _ready():
	if OS.get_name() == "HTML5":
		exit_btn.hide()

func _on_Exit_pressed():
	get_tree().quit()
