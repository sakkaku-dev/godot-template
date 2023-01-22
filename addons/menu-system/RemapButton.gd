class_name RemapButton
extends Button

var action := ""
var input := PlayerInput.new()

func _ready():
	_update()

func _update():
	var ev = get_input()
	text = InputType.to_text(InputType.to_type(ev))

func get_input() -> InputEvent:
	var inputs = InputMap.get_action_list(action)
	for i in inputs:
		if input.is_player_event(i):
			return i
	return null


func remap_input(ev: InputEvent) -> void:
	var existing = get_input()
	if existing:
		InputMap.action_erase_event(action, existing)
	InputMap.action_add_event(action, ev)
	
	_update()