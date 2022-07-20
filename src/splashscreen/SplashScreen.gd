extends Control

export var next_screen: PackedScene

onready var tween: TweenEffect = $Tween


func _ready():
	tween.start()


func _on_Tween_tween_all_completed():
	print("completed")
	if tween.reverse:
		tween.reverse = false
		tween.start()
	else:
		get_tree().change_scene_to(next_screen)

