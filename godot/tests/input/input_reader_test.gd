extends BaseInputTest

var input: InputReader


func before_each():
	input = autofree(InputReader.new())


func test_single_input():
	input.handle_input(press_key("move_left"))
	assert_true(input.is_pressed("move_left"))

	input.handle_input(release_key("move_left"))
	assert_false(input.is_pressed("move_left"))


func test_multiple_input():
	input.handle_input(press_key("move_left"))
	input.handle_input(press_key("move_right"))

	assert_true(input.is_pressed("move_left"))
	assert_true(input.is_pressed("move_right"))

	input.handle_input(release_key("move_right"))
	assert_true(input.is_pressed("move_left"))
	assert_false(input.is_pressed("move_right"))


func test_action_strength():
	input.handle_input(press_key("move_left", 1))
	assert_eq(input.get_action_strength("move_left"), 1.0)

	input.handle_input(joypad_motion_event(JOY_AXIS_LEFT_X, 1))
	assert_eq(input.get_action_strength("move_right"), 1.0)

	assert_eq(input.get_action_strength("ui_up"), 0.0)


func test_just_pressed_and_released():
	watch_signals(input)

	var ev = press_key("move_left")
	input.handle_input(ev)
	assert_signal_emitted_with_parameters(input, "just_pressed", [ev])

	ev = release_key("move_left")
	input.handle_input(ev)
	assert_signal_emitted_with_parameters(input, "just_released", [ev])


func test_disable_input():
	input.disable()
	input.handle_input(press_key("move_left", 1))
	assert_eq(input.get_action_strength("move_left"), 0.0)


func test_empty_inputs_on_disable():
	input.handle_input(press_key("move_left", 1))
	assert_eq(input.get_action_strength("move_left"), 1.0)

	input.disable()
	assert_eq(input.get_action_strength("move_left"), 0.0)


func test_disabled_exceptions():
	input.disable(["move_left"])
	input.handle_input(press_key("move_left", 1))

	assert_eq(input.get_action_strength("move_left"), 1.0)
	assert_true(input.is_pressed("move_left"))
