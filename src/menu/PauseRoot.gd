extends CanvasLayer

@export var start_scene: PackedScene

@onready var back_button := $Control/Pause/CenterContainer/VBoxContainer/Back

func _ready():
	back_button.visible = !!start_scene

func _on_Back_pressed():
	if start_scene:
		get_tree().change_scene_to(start_scene)
