class_name PositionEffect
extends Effect

@export var dir := Vector2.UP
@export var amount := 5

@onready var start_pos = get_parent().position

func setup():
	_interpolate("position", start_pos, start_pos + dir * amount)
