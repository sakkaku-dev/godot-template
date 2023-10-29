extends BaseInputTest

var player_input: PlayerInput


func before_each():
	player_input = autofree(PlayerInput.new())


func test_ignore_joypad_if_disabled():
	player_input.joypad = false

	player_input.handle_input(press_key("move_left", 1))
	assert_true(player_input.is_pressed("move_left"))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_LEFT_X, 1))
	assert_false(player_input.is_pressed("move_right"))


func test_only_read_joypad_if_enabled():
	player_input.joypad = true

	player_input.handle_input(press_key("move_left", 1))
	assert_false(player_input.is_pressed("move_left"))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_LEFT_X, 1))
	assert_true(player_input.is_pressed("move_right"))


func test_device_id():
	player_input.device_id = 100

	var ev = press_key("move_left")

	player_input.handle_input(ev)
	assert_false(player_input.is_pressed("move_left"))

	ev.device = 100
	player_input.handle_input(ev)
	assert_true(player_input.is_pressed("move_left"))
