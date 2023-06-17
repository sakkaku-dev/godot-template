extends Node

const DEV_VERSION = "DEV"

var version = DEV_VERSION


func _ready():
	if is_prod():
		version = Build.VERSION


func is_prod() -> bool:
	return version != DEV_VERSION


func is_web() -> bool:
	return OS.get_name() == "HTML5"
