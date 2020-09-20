class_name Mockito

const ScriptDirector = preload("res://addons/WAT/core/double/script_director.gd")
const SceneDirector = preload("res://addons/WAT/core/double/scene_director.gd")

static func mock(cls) -> ScriptDirector:
	var factory = WAT.TestDoubleFactory.new()
	return factory.script(cls)

static func add_children(root: Node, node_dic: Dictionary) -> Node:
	for name in node_dic.keys():
		add_child(root, node_dic.get(name), name)
	return root

static func add_child(root: Node, script: ScriptDirector, name: String) -> void:
	var node = script.double()
	node.name = name
	root.add_child(node)
