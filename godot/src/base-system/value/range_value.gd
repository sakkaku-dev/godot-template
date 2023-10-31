class_name RangeValue
extends ValueProvider

@export var start := 0.0
@export var end := 1.0
@export var value := 0.5

func get_value():
	var diff = end - start
	return start + value * diff
