class_name HurtBox
extends Area2D

@export var health: Health
@export var hit_sound: AudioStreamPlayer
@export var frame_freeze: FrameFreeze
@export var hit_flash: HitFlash2D

@export var invincible_time := 0.0

signal hit(dmg)
signal knockback(dir)

var invincible := false

func damage(dmg: int, knockback_force: Vector2):
	if invincible:
		return false
	
	invincible = true
	hit.emit(dmg)
	if knockback_force:
		knockback.emit(knockback_force)
	
	if health:
		health.hurt(dmg)
	if hit_sound:
		hit_sound.play()
	if hit_flash:
		hit_flash.flash()
	if frame_freeze and not health.is_dead():
		frame_freeze.freeze()
	
	get_tree().create_timer(invincible_time).timeout.connect(func(): invincible = false)
