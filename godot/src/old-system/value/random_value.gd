class_name RandomValue
extends ValueProvider

@export var start := 0.0
@export var end := 1.0

func get_value():
	return randf_range(start, end)
