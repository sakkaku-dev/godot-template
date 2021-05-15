extends Area2D

class_name HitBox

export var damage = 1
export var free_on_hit = true

func _ready():
	connect("area_entered", self, "_on_HitBox_area_entered")

func _on_HitBox_area_entered(area):
	if area is HurtBox:
		area.damage(damage)
		queue_free()
