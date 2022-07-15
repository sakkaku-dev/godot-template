extends Control

signal finished

export var playback_speed := 1.0
export var reverse := false
export var start := false

onready var anim := $AnimationPlayer

func _ready():
	if start:
		start()
		
func start():
	anim.playback_speed = playback_speed
	anim.play(_get_anim())

func _get_anim() -> String:
	return "Reverse" if reverse else "Start"

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished")
