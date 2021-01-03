extends Node

signal zero_health
signal health_changed(hp)
signal max_health_changed(hp)

class_name Health

export var max_health = 10 setget set_max_health
onready var health = max_health setget _set_health

func _ready():
	# use deferred so the values are initialized before emitting
	call_deferred("emit_signal", "max_health_changed", max_health)
	call_deferred("emit_signal", "health_changed", health)

func reduce(value: int) -> void:
	self.health -= value


func increase(value: int) -> void:
	self.health += value


func _set_health(hp: int) -> void:
	health = clamp(hp, 0, max_health)
	emit_signal("health_changed", health)

	if health <= 0:
		health = 0
		emit_signal("zero_health")

func set_max_health(hp: int) -> void:
	max_health = clamp(hp, 1, hp)
	emit_signal("max_health_changed", max_health)
