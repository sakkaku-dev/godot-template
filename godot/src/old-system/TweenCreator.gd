class_name TweenCreator

var node: Node
var tw: Tween
var default_duration := 0.5
var block = true
var trans = Tween.TRANS_CUBIC
var ease = Tween.EASE_IN_OUT

static func create(n):
	return TweenCreator.new(n)

func _init(n: Node):
	node = n

func new_tween(on_finish = null):
	if tw and tw.is_running():
		if block:
			return false
		else:
			tw.kill()
	
	tw = node.create_tween()
	tw.set_parallel()
	tw.set_trans(trans)
	tw.set_ease(ease)
	if on_finish:
		tw.finished.connect(on_finish)
	return true

func fade_out(n, duration = default_duration):
	return prop(n, "modulate", Color.WHITE, Color.TRANSPARENT, duration).set_ease(Tween.EASE_IN)

func fade_in(n, duration = default_duration):
	return prop(n, "modulate", Color.TRANSPARENT, Color.WHITE, duration).set_ease(Tween.EASE_OUT)

func slide_in(n, dir: Vector2, pos = Vector2.ZERO, dist = n.size, duration = default_duration):
	return prop(n, "position", pos - dir * dist, pos, duration).set_ease(Tween.EASE_OUT)

func slide_out(n, dir: Vector2, dist = n.size, duration = default_duration):
	return prop(n, "position", n.position, n.position + dir * dist, duration).set_ease(Tween.EASE_IN)

func scale_in(n, target_scale = Vector2(1, 1), duration = default_duration):
	return scale(n, Vector2.ZERO, target_scale, duration).set_ease(Tween.EASE_OUT)
	
func scale_out(n, init_scale = Vector2(1, 1), duration = default_duration):
	return scale(n, init_scale, Vector2.ZERO, duration).set_ease(Tween.EASE_IN)
	
func scale(n, from: Vector2, to: Vector2, duration = default_duration):
	if n is Control:
		n.pivot_offset = n.size / 2
	return prop(n, "scale", from, to, duration)

func prop(n, p: String, from, to, duration = default_duration):
	return tw.tween_property(n, p, to, duration).from(from)
