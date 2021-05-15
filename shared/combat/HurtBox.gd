extends Area2D

class_name HurtBox

signal hit
signal damaged(dmg)
signal invincibility_timeout

export var invincibility = true

onready var invincibility_timer := $InvincibilityTimer
onready var collision := $CollisionShape2D


func damage(dmg: int):
	emit_signal("damaged", dmg)
	emit_signal("hit")
	if invincibility:
		collision.set_deferred("disabled", true)
		invincibility_timer.start()


func _on_InvincibilityTimer_timeout():
	collision.disabled = false
	emit_signal("invincibility_timeout")
