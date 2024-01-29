extends Node

@export var ctrl: CharacterController
@export var speed_value: ValueProvider
@export var speed := 300
@export var accel := 900

@export var debug := false

var _logger := Logger.new("TopDownMove2D")

func move(velocity: Vector2, delta: float):
	var motion = Vector2.ZERO
	if ctrl:
		motion = ctrl.get_motion()
	
	if debug:
		_logger.debug("Moving to %s" % motion)
		
	var s = _get_speed()
	return velocity.move_toward(motion * s, accel * delta)

func _get_speed():
	return speed_value.get_value() if speed_value else speed