class_name AudioSlider
extends HSlider

@export var bus_name := "Master"

var master_id
var vol_range = 60
var vol_offset = 5

func _ready():
	master_id = AudioServer.get_bus_index(bus_name)
	connect("value_changed", self._volume_changed)
	value = get_volume_percentage()

func _volume_changed(v: float):
	if v == 0:
		AudioServer.set_bus_mute(master_id, true)
	else:
		AudioServer.set_bus_mute(master_id, false)
		AudioServer.set_bus_volume_db(master_id, get_volume(v))

func get_volume(percentage: float) -> float:
	var vol_value = -vol_range + (vol_range * percentage / 100) # Volume from -vol_range to 0
	vol_value += vol_offset
	return vol_value

func get_volume_percentage():
	var volume = AudioServer.get_bus_volume_db(master_id)
	return (volume - vol_offset + vol_range) * 100 / vol_range # Just reversed the equation of #get_volume
