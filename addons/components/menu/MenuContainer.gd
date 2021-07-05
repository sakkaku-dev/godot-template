extends Menu

class_name MenuContainer

func _ready():
	for c in get_children():
		c.connect("visibility_changed", self, "_hide_other", [c])

func _hide_other(node: Control) -> void:
	if node.visible:
		for c in get_children():
			if c != node:
				c.hide()

