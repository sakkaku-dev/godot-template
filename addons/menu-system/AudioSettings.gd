extends Control

const AUDIO_SECTION = "audio"

var _logger = Logger.new("AudioSettings")

func load_settings(config: ConfigFile):
	for i in range(0, AudioServer.bus_count):
		var name = AudioServer.get_bus_name(i)
		var value = config.get_value(AUDIO_SECTION, name)
		if value != null:
			_logger.debug("Loading audio setting for %s: %s" % [name, value])
			AudioServer.set_bus_volume_db(i, value)

func save_settings(config: ConfigFile):
	for i in range(0, AudioServer.bus_count):
		var name = AudioServer.get_bus_name(i)
		var value = AudioServer.get_bus_volume_db(i)
		_logger.debug("Saving audio setting for %s: %s" % [name, value])
		config.set_value(AUDIO_SECTION, name, value)
