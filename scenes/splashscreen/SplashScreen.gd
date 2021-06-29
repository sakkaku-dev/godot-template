extends Control

onready var background := $Background
onready var color = ProjectSettings.get_setting("application/boot_splash/bg_color")

func _ready():
	background.color = color


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Game.tscn")
