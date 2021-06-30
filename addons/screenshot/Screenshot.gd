extends Node

export var output_path = "res://screenshots"

onready var main = ProjectSettings.get_setting("application/run/main_scene")

func take_screenshot(name: String):
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.save_png(output_path + "/" + name)


func _ready():
	var dir = Directory.new()
	if not dir.file_exists(output_path):
		dir.make_dir_recursive(output_path)
		
	var main_scene = load(main).instance()
	get_tree().current_scene.add_child(main_scene)
	
	run()
	
	get_tree().quit()


func run():
	take_screenshot("test.png")

