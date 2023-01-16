class_name CacheManager
extends Node

const PERSIST_GROUP = "Persist"

var logger = Logger.new("CacheManager")
var scene_data = {}


func save_scene():
	var scene = get_tree().current_scene
	var data = _get_persist_group_data()
	if not data.empty():
		scene_data[scene.name] = data
		logger.debug("Save scene data: %s" % scene_data)


func load_scene():
	var scene = get_tree().current_scene
	if scene_data.has(scene.name):
		var data = scene_data[scene.name]
		_load_perist_group_data(data)
		logger.debug("Load scene data: %s" % data)


func _get_persist_group_data(global: bool = false):
	var node_data = {}
	for node in get_tree().get_nodes_in_group(PERSIST_GROUP):
		if node.has_method("save_data"):
			var path = get_tree().current_scene.get_path_to(node)
			if not global and ".." == path.get_name(0):
				continue
			node_data[path] = node.save_data()
	return node_data


func _load_perist_group_data(node_data: Dictionary):
	for node_name in node_data:
		var node = get_tree().current_scene.get_node(node_name)
		if node:
			var path = get_tree().current_scene.get_path_to(node)
			if node_data.has(path) and node.has_method("load_data"):
				var data = node_data[path]
				node.load_data(data)
