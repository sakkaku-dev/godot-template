class_name AreaSpawner2D
extends Spawner2D

@export var center_offset := 10
@export var count := 6
@export_range(0, 360, 1) var spread := 360

func spawn():
	var dir = Vector2.RIGHT.rotated(global_rotation)
	var spread = PI
	for i in count:
		var start = dir.rotated(-spread/2)
		var d = start.rotated(i * spread/count)
		_create(d * center_offset)
