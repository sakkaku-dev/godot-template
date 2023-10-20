extends Node

var log_level := Logger.Level.DEBUG
var version := "dev" : set = _set_version
var _logger := Logger.new("Env")
var _demo := false

func _ready():
	if is_prod():
		log_level = Logger.Level.INFO

	_logger.info("Running version %s on %s" % [version, OS.get_name()])

func _set_version(v: String) -> void:
	if v == "": return
	version = v

	if is_prod():
		_demo = true # TODO: steam

func is_prod() -> bool:
	return version != "dev"

func is_web() -> bool:
	return OS.has_feature("web")

func is_demo() -> bool:
	return _demo