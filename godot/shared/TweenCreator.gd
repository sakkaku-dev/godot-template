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

func fade_out(node, duration = default_duration):
	return tw.tween_property(node, "modulate", Color.TRANSPARENT, duration).from(Color.WHITE).set_ease(Tween.EASE_IN)

func fade_in(node, duration = default_duration):
	return tw.tween_property(node, "modulate", Color.WHITE, duration).from(Color.TRANSPARENT).set_ease(Tween.EASE_OUT)

func slide_in(node, dir: Vector2, pos = Vector2.ZERO, dist = node.size, duration = default_duration):
	return tw.tween_property(node, "position", pos, duration).from(pos - dir * dist).set_ease(Tween.EASE_OUT)

func slide_out(node, dir: Vector2, dist = node.size, duration = default_duration):
	return tw.tween_property(node, "position", node.position + dir * dist, duration).from(node.position).set_ease(Tween.EASE_IN)

func scale_in(node, target_scale = Vector2(1, 1), duration = default_duration):
	if node is Control:
		node.pivot_offset = node.size / 2
	return tw.tween_property(node, "scale", target_scale, duration).from(Vector2.ZERO).set_ease(Tween.EASE_OUT)

func scale_out(node, init_scale = Vector2(1, 1), duration = default_duration):
	if node is Control:
		node.pivot_offset = node.size / 2
	return tw.tween_property(node, "scale", Vector2.ZERO, duration).from(init_scale).set_ease(Tween.EASE_IN)
