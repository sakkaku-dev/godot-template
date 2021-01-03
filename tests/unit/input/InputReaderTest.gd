extends UnitTest

var input: InputReader


func before_each():
	input = autofree(InputReader.new())


func test_single_input():
	input.handle_input(press_key(InputReader.MOVE_LEFT))
	assert_true(input.is_pressed([InputReader.MOVE_LEFT]))

	input.handle_input(release_key(InputReader.MOVE_LEFT))
	assert_false(input.is_pressed([InputReader.MOVE_LEFT]))


func test_multiple_input():
	input.handle_input(press_key(InputReader.MOVE_LEFT))
	input.handle_input(press_key(InputReader.JUMP))

	assert_true(input.is_pressed([InputReader.MOVE_LEFT, InputReader.JUMP]))

	input.handle_input(release_key(InputReader.JUMP))
	assert_false(input.is_pressed([InputReader.MOVE_LEFT, InputReader.JUMP]))
	assert_true(input.is_pressed([InputReader.MOVE_LEFT]))


func test_action_strength():
	input.handle_input(press_key(InputReader.MOVE_LEFT, 1))
	assert_eq(input.get_action_strength(InputReader.MOVE_LEFT), 1)

	input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_eq(input.get_action_strength(InputReader.MOVE_RIGHT), 1)

	assert_eq(input.get_action_strength(InputReader.JUMP), 0)


func test_just_pressed():
	input.handle_input(press_key(InputReader.JUMP))
	assert_true(input.is_just_pressed(InputReader.JUMP))

	simulate(input, 1, 1)
	assert_false(input.is_just_pressed(InputReader.JUMP))
