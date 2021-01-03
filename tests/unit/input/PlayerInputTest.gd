extends UnitTest

var player_input: PlayerInput


func before_each():
	player_input = autofree(PlayerInput.new())


func test_move_vector():
	player_input.handle_input(press_key(PlayerInput.MOVE_LEFT, 1))
	assert_eq(player_input.get_move_vector(), Vector2(-1, 0))

	player_input.handle_input(press_key(PlayerInput.MOVE_RIGHT, 1))
	assert_eq(player_input.get_move_vector(), Vector2(0, 0))

	player_input.handle_input(release_key(PlayerInput.MOVE_LEFT))
	assert_eq(player_input.get_move_vector(), Vector2(1, 0))


func test_joypad_motion():
	player_input.joypad_input = true

	# Joypad can set the action strength of left and right in one event
	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_eq(player_input.get_move_vector(), Vector2(1, 0))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, -1))
	assert_eq(player_input.get_move_vector(), Vector2(-1, 0))


func test_ignore_joypad_if_disabled():
	player_input.joypad_input = false

	player_input.handle_input(press_key(PlayerInput.MOVE_LEFT, 1))
	assert_eq(player_input.get_move_vector(), Vector2(-1, 0))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_eq(player_input.get_move_vector(), Vector2(-1, 0))


func test_only_read_joypad_if_enabled():
	player_input.joypad_input = true

	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_eq(player_input.get_move_vector(), Vector2(1, 0))

	player_input.handle_input(press_key(PlayerInput.MOVE_LEFT, 1))
	assert_eq(player_input.get_move_vector(), Vector2(1, 0))


func test_device_id():
	var input = autofree(PlayerInput.new(100))

	var ev = press_key(PlayerInput.JUMP)

	input.handle_input(ev)
	assert_false(input.is_pressed([PlayerInput.JUMP]))

	ev.device = 100
	input.handle_input(ev)
	assert_true(input.is_pressed([PlayerInput.JUMP]))
