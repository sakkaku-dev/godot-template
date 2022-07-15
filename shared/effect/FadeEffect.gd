class_name FadeEffect extends Effect


func apply_tween(tween: Tween, reverse: bool):
	interpolate_with_reverse(tween, "modulate", Color.transparent, reverse)
