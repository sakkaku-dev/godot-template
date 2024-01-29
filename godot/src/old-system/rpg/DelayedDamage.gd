class_name DelayedDamage
extends Timer

@export var health: Health
@export var damage := 1

func _ready():
	timeout.connect(func():
		if health:
			health.hurt(damage)
	)
