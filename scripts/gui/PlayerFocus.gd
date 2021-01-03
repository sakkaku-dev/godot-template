extends Focusable

"""
Control that a single player input can focus and control
"""

class_name PlayerFocus

var input: PlayerInput

func focus_player(player: PlayerInput):
	input = player
	focus()

func can_handle_event(event: InputEvent) -> bool:
	return is_focused and input and input.is_player_event(event)
