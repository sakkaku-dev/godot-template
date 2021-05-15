extends Node2D

class_name Spawner

signal spawned

export(Array, PackedScene) var scene: Array
export var spawn_delay = 1.0
export var spawn = false

export(Array, float) var scene_spawn_rate: Array

onready var timer = $Timer

var can_spawn = true

func _ready():
	if scene_spawn_rate.size() < scene.size():
		var current_sum = 0.0
		for rate in scene_spawn_rate:
			current_sum += rate
		
		var missing_rates = scene.size() - scene_spawn_rate.size()
		var rate = (1 - current_sum) / missing_rates
		for i in range(0, missing_rates):
			current_sum += rate
			scene_spawn_rate.append(current_sum)


func set_spawn(value):
	spawn = value


func _process(delta):
	if spawn and can_spawn:
		_spawn_all()


func _get_all_spawn_pos() -> Array:
	var spawn_pos = []
	for c in get_children():
		if c is Position2D:
			spawn_pos.append(c)
	return spawn_pos


func _get_random_scene() -> PackedScene:
	var rand = Random.random_double()
	
	var rate_sum = 0
	for i in range(0, scene.size()):
		rate_sum = scene_spawn_rate[i]
		if rand <= rate_sum:
			return scene[i]
	
	return null


func _spawn_all():
	for spawn_pos in _get_all_spawn_pos():
		_spawn(spawn_pos)

	emit_signal("spawned")
	can_spawn = false
	timer.start(spawn_delay)


func _spawn(spawn_pos: Node2D):
	var scene = _get_random_scene()
	if not scene: return
	
	var instance = scene.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_transform = spawn_pos.global_transform
	instance.global_rotation = spawn_pos.global_rotation


func _on_Timer_timeout():
	can_spawn = true
