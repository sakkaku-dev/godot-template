extends Node

const SAVES_FOLDER = "user://saves"
const SAVE_FILE = SAVES_FOLDER + "/save_%s.dat"

var logger = Logger.new("SaveManager")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	var dir = Directory.new()
	if not dir.dir_exists(SAVES_FOLDER):
		dir.make_dir(SAVES_FOLDER)
	

func save_to_slot(slot: int, data):
	var file = File.new()
	var file_name = SAVE_FILE % slot
	var error = file.open(file_name, File.WRITE)
	if error:
		logger.error("Failed to save data to %s: %s" % [file_name, error])
	else:
		file.store_var(data)
		logger.debug("Save %s" % str(data))
	file.close()
	
func load_from_slot(slot: int):
	var file = File.new()
	var file_name = SAVE_FILE % slot
	var error = file.open(file_name, File.READ)
	var data
	if error:
		logger.error("Failed to load data from %s: %s" % [file_name, error])
	else:
		data = file.get_var()
		if data:
			logger.debug("Load %s" % str(data))
	file.close()
	
	return data


func is_slot_saved(slot: int):
	var file = File.new()
	var file_name = SAVE_FILE % slot
	var error = file.open(file_name, File.READ)
	
	var found = false
	if error:
		logger.error("Failed to load data from %s: %s" % [file_name, error])
	else:
		found = true
	file.close()

	return found

