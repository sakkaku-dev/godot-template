extends BaseInputTest

func test_to_type():
	assert_eq(InputType.to_type(null), 1)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_0, 0)), 1)
	
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_0, -1)), InputType.Key.JOYSTICK_L_LEFT)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_0, 1)), InputType.Key.JOYSTICK_L_RIGHT)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_1, -1)), InputType.Key.JOYSTICK_L_UP)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_1, 1)), InputType.Key.JOYSTICK_L_DOWN)
	
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_2, -1)), InputType.Key.JOYSTICK_R_LEFT)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_2, 1)), InputType.Key.JOYSTICK_R_RIGHT)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_3, -1)), InputType.Key.JOYSTICK_R_UP)
	assert_eq(InputType.to_type(joypad_motion_event(JOY_AXIS_3, 1)), InputType.Key.JOYSTICK_R_DOWN)
	
	assert_eq(InputType.to_type(mouse_event(BUTTON_LEFT)), InputType.Key.MOUSE_LEFT)
	assert_eq(InputType.to_type(mouse_event(BUTTON_MIDDLE)), InputType.Key.MOUSE_MIDDLE)

	assert_eq(InputType.to_type(key_event(KEY_A)), -KEY_A)
	assert_eq(InputType.to_type(key_event(KEY_CONTROL)), -KEY_CONTROL)
	assert_eq(InputType.to_type(key_event(KEY_ESCAPE)), -KEY_ESCAPE)


func _convert_to_same(ev: InputEvent) -> void:
	assert_eq(InputType.to_event(InputType.to_type(ev)), ev)

func test_convert():
	assert_eq(InputType.to_event(InputType.Key.MOUSE_RIGHT).button_index, BUTTON_RIGHT)
	assert_eq(InputType.to_event(InputType.Key.JOYSTICK_R_DOWN).axis, JOY_AXIS_3)
	assert_eq(InputType.to_event(-KEY_A).scancode, KEY_A)


func test_to_text():
	assert_eq(InputType.to_text(InputType.Key.MOUSE_LEFT), "MOUSE_LEFT")
