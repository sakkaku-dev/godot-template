extends Node

var log_level := Logger.Level.DEBUG
var version := "dev" : set = _set_version
var _logger := Logger.new("Env")
var _demo := false

func _ready():
	if is_prod():
		log_level = Logger.Level.INFO

	var args = Array(OS.get_cmdline_args())
	if args.has("--live"):
		_demo = false
	if args.has("--steam"):
		_enable_steam = true
	if args.has("--debug"):
		log_level = Logger.Level.DEBUG

	_logger.info("Running version %s on %s" % [version, OS.get_name()])

func is_prod() -> bool:
	return not OS.is_debug_build()

func is_web() -> bool:
	return OS.has_feature("web")

func is_demo() -> bool:
	return _demo and is_prod()

func is_steam() -> bool:
	return _enable_steam or not is_prod() # always enable for play testing in editor