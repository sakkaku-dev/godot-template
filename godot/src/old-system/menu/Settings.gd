class_name Settings
extends Control

const CONFIG_FILE = "user://settings.cfg"

@onready var _audio := $Audio

var _logger = Logger.new("Settings")
var _config = ConfigFile.new()

func _ready():
	_load_settings()

func _load_settings():
	var error = _config.load(CONFIG_FILE)
	if error != OK:
		_logger.error("Failed to load settings: %s" % error)
	
	_logger.debug("Loading settings")
	_audio.load_settings(_config)

func _exit_tree():
	_save_config()

func _save_config():
	if Env.is_web(): return
	
	_logger.debug("Saving settings")
	_audio.save_settings(_config)
	_config.save(CONFIG_FILE)
