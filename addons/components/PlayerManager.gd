class_name PlayerManager

var players = []

func _is_join_event(event: InputEvent) -> bool:
	if event is InputEventJoypadButton or event is InputEventKey:
		return event.is_action_pressed("ui_accept")
	return false

func add_player(event: InputEvent) -> PlayerInput:
	if not _is_join_event(event): return null
	
	var input = PlayerInput.new()
	input.set_for_event(event)
	
	var data = {
		"device": input.device_id,
		"joypad": input.joypad_input,
	}
	
	if player_exists(data):
		print("Player already exists")
		return null
	
	players.append(data)
	print("Player added: " + str(data))
	return input


func player_exists(player_data: Dictionary) -> bool:
	for input in players:
		if input["device"] == player_data["device"] and \
			input["joypad"] == player_data["joypad"]:
			return true
	return false
