extends UnitTest

var input: TouchReader


func before_each():
	input = autofree(TouchReader.new())
	input.swipe_threshold = 10
	watch_signals(input)


func test_mouse_swipe_right():
	input._input(mouse_button_event(BUTTON_LEFT, Vector2(0, 0)))
	input._input(mouse_button_event(BUTTON_LEFT, Vector2(20, 0), false))
	
	assert_signal_emitted_with_parameters(input, "swipe", [false])


func test_mouse_swipe_left():
	input._input(mouse_button_event(BUTTON_LEFT, Vector2(0, 0)))
	input._input(mouse_button_event(BUTTON_LEFT, Vector2(-20, 0), false))
	
	assert_signal_emitted_with_parameters(input, "swipe", [true])
