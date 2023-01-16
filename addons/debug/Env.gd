extends Node

enum Level {
	ERROR,
	INFO,
	WARN,
	DEBUG,
	TRACE,
}

const DEV_VERSION = "DEV"
const DEBUG_SCENE = preload("res://addons/debug/Debug.tscn")

var version = DEV_VERSION
var log_level = Level.DEBUG


func _ready():
	if is_prod():
		log_level = Level.INFO
		version = Build.VERSION


func _unhandled_input(event):
	if event.is_action_pressed("dev"):
		if get_child_count() == 0:
			add_child(DEBUG_SCENE.instance())
		else:
			remove_child(get_child(0))


func is_prod() -> bool:
	return version != DEV_VERSION


func is_web() -> bool:
	return OS.get_name() == "HTML5"
