class_name Hand extends Area2D

var last_interacted: Interactable
var closest: Interactable


func _ready():
	connect("area_exited", _on_exit)


func _on_exit(area):
	area.unhighlight()


func reinteract():
	if last_interacted:
		last_interacted.interact()


func interact():
	if closest:
		closest.interact()
		last_interacted = closest


func _process(_delta):
	closest = _get_closest_interactable()
	_update_hightlight()


func _update_hightlight():
	if monitoring:
		for area in get_overlapping_areas():
			if area == closest:
				area.highlight()
			else:
				area.unhighlight()


func _get_closest_interactable():
	var closest_item = null
	var closest_item_dot_scale = -1
	if monitoring:
		for area in get_overlapping_areas():
			if closest_item == null:
				closest_item = area
			else:
				var item_dir = (area.global_position - global_position).normalized()
				var hand_dir = Vector2.RIGHT * scale.x
				var dot_scale = item_dir.dot(hand_dir)

				if dot_scale > closest_item_dot_scale:
					closest_item = area
					closest_item_dot_scale = dot_scale

	return closest_item
