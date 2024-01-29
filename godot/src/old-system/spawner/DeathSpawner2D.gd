class_name DeathSpawner2D
extends Node2D

@export var spawn_chance_value: ValueProvider
@export var spawn_chance := 1.0
@export var health: Health
@export var scene: PackedScene

func _ready():
	if health:
		health.zero_health.connect(func(): _create())

func _should_spawn():
	return randf() <= _get_spawn_chance()

func _get_spawn_chance():
	return spawn_chance_value.get_value() if spawn_chance_value else spawn_chance

func _create():
	if not _should_spawn():
		return
	
	var x = scene.instantiate()
	x.global_position = global_position
	x.global_rotation = global_rotation
	get_tree().current_scene.call_deferred("add_child", x)
