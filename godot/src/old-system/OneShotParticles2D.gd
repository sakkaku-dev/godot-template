class_name OneShotParticles
extends GPUParticles2D

signal finished()

@export var wait_time := -1.0
@onready var time := lifetime if wait_time < 0 else wait_time

func _ready():
	emitting = true
	get_tree().create_timer(time).timeout.connect(func():
		finished.emit()
		queue_free()
	)
