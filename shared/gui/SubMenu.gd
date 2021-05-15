extends Control

signal go_back

func _unhandled_input(event):
	if visible and event.is_action("ui_cancel"):
		emit_signal("go_back")
