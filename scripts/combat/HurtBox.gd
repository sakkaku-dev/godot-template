extends Area2D

class_name HurtBox

signal damaged(dmg)

func damage(dmg: int):
	emit_signal("damaged", dmg)
