class_name Effect extends Node

export var delay = 0.0
export var duration = 0.5

export(Array, NodePath) var node_paths: Array

var transition = Tween.TRANS_LINEAR
var ease_type = Tween.EASE_IN_OUT


func get_nodes() -> Array:
	var result = []
	for node_path in node_paths:
		result.append(get_node(node_path))
	return result


func interpolate_all(tween: Tween, property: String, start_value, end_value):
	for node in get_nodes():
		var start = node.get(start_value) if start_value is String else start_value
		var end = node.get(end_value) if end_value is String else end_value

		tween.interpolate_property(
			node, property, start, end, duration, transition, ease_type, delay
		)

		node.set(property, start)


func interpolate_with_reverse(tween: Tween, property: String, end_value, reverse: bool):
	if reverse:
		interpolate_all(tween, property, end_value, property)
	else:
		interpolate_all(tween, property, property, end_value)


func apply_tween(_tween: Tween, _reverse: bool):
	pass
