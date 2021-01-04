extends Area2D

export var damage = 1

func _on_HitBox_area_entered(area):
	if area is HurtBox:
		area.damage(damage)
