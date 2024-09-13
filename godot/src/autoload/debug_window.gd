extends CanvasLayer

@export var logs: RichTextLabel

func _ready() -> void:
	hide()
	InputMapper.add_input("debug", KEY_F1)
	GameManager.logged.connect(func(txt): logs.text += txt + "\n")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug") and Env.is_debug_level():
		visible = not visible
