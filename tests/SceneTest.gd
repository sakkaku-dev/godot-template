extends UnitTest

class_name SceneTest

var root: Node


func press_key(input: String, strength = 0) -> InputEvent:
	return enter_input(.press_key(input, strength))


func release_key(input: String) -> InputEvent:
	return enter_input(.release_key(input))


func enter_input(ev: InputEvent) -> InputEvent:
	get_tree().input_event(ev)
	return ev


func init_scene(scene_path: String) -> void:
	var scene = load(scene_path) as PackedScene
	var node = scene.instance()

	add_child_autofree(node)
	root = node


func simulate_all(times: int, delta: float) -> void:
	simulate(root, times, delta)


func get_root_node(path: String) -> Node:
	return root.get_node(path)
