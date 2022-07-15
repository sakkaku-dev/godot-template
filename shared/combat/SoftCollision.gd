class_name SoftCollision extends Area2D

var push_factor := 0.0

func _process(delta):
	for area in get_overlapping_areas():
		pass

func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if areas.size() > 0:
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized() * area.push_factor
	return push_vector
