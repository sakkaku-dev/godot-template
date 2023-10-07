class_name AudioSettings
extends Control

signal loaded()

const AUDIO_SECTION = "audio"

var _logger = Logger.new("AudioSettings")

func load_settings(config: ConfigFile):
	for i in range(0, AudioServer.bus_count):
		var name = AudioServer.get_bus_name(i)
		var value = config.get_value(AUDIO_SECTION, name)
		if value != null:
			var split = str(value).split(";")
			_logger.debug("Loading audio setting for %s: %s" % [name, value])
			AudioServer.set_bus_volume_db(i, float(split[0]))
			AudioServer.set_bus_mute(i, split.size() > 1 and split[1] == "true")
			
	loaded.emit()

func save_settings(config: ConfigFile):
	for i in range(0, AudioServer.bus_count):
		var name = AudioServer.get_bus_name(i)
		var value = AudioServer.get_bus_volume_db(i)
		var muted = AudioServer.is_bus_mute(i)
		_logger.debug("Saving audio setting for %s: %s, %s" % [name, value, muted])
		config.set_value(AUDIO_SECTION, name, "%s;%s" % [value, muted])
