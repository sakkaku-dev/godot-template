class_name PositionEffect
extends Effect

@export var dir := Vector2.UP
@export var amount := 5

@onready var start = get_parent().position

func setup():
	_interpolate("position", start, start + dir * amount)
