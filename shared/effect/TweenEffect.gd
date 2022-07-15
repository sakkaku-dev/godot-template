class_name TweenEffect extends Tween

export var initialize = false
export var reverse = false

var called = 0

func _ready():
	if initialize:
		_apply()


func start():
	if is_active():
		return
	
	if not initialize or called > 0:
		_apply()
	
	called += 1
	return .start()


func _apply():
	for child in get_children():
		if child is Effect:
			child.apply_tween(self, reverse)
