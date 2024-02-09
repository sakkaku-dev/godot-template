class_name InputType extends Node

# Create a custom Map for the mappable keys since Godot does not group controller/keyboard/etc as one enum
enum Key {
	MOUSE_LEFT = 2,
	MOUSE_RIGHT,
	MOUSE_MIDDLE,
	
	# Motion
	JOYSTICK_L_UP,
	JOYSTICK_L_DOWN,
	JOYSTICK_L_RIGHT,
	JOYSTICK_L_LEFT,
	
	JOYSTICK_R2,
	JOYSTICK_L2,
	
	JOYSTICK_R_UP,
	JOYSTICK_R_DOWN,
	JOYSTICK_R_RIGHT,
	JOYSTICK_R_LEFT,
	
	# Buttons
	JOYSTICK_START,
	JOYSTICK_R1,
	JOYSTICK_L1,
	JOYSTICK_A,
	JOYSTICK_B,
	JOYSTICK_X,
	JOYSTICK_Y,
	JOYSTICK_DPAD_UP,
	JOYSTICK_DPAD_DOWN,
	JOYSTICK_DPAD_LEFT,
	JOYSTICK_DPAD_RIGHT,
	JOYSTICK_L_CLICK,
	JOYSTICK_R_CLICK,
	JOYSTICK_HOME,
	JOYSTICK_SELECT,
}

const JOY_MOTION_MAP = {
	Key.JOYSTICK_L_RIGHT: [JOY_AXIS_LEFT_X, 1],
	Key.JOYSTICK_L_LEFT: [JOY_AXIS_LEFT_X, -1],
	Key.JOYSTICK_L_DOWN: [JOY_AXIS_LEFT_Y, 1],
	Key.JOYSTICK_L_UP: [JOY_AXIS_LEFT_Y, -1],
	Key.JOYSTICK_R_RIGHT: [JOY_AXIS_RIGHT_X, 1],
	Key.JOYSTICK_R_LEFT: [JOY_AXIS_RIGHT_X, -1],
	Key.JOYSTICK_R_DOWN: [JOY_AXIS_RIGHT_Y, 1],
	Key.JOYSTICK_R_UP: [JOY_AXIS_RIGHT_Y, -1],
	Key.JOYSTICK_L2: [JOY_AXIS_TRIGGER_LEFT, 1],
	Key.JOYSTICK_R2: [JOY_AXIS_TRIGGER_RIGHT, 1],
}

const JOY_BUTTON_MAP = {
	JOY_BUTTON_LEFT_SHOULDER: Key.JOYSTICK_L1,
#	JOY_BUTTON_LEFT_STICK: Key.JOYSTICK_L2,
	JOY_BUTTON_RIGHT_SHOULDER: Key.JOYSTICK_R1,
#	JOY_BUTTON_RIGHT_STICK: Key.JOYSTICK_R2,
	JOY_BUTTON_LEFT_STICK: Key.JOYSTICK_L_CLICK,
	JOY_BUTTON_RIGHT_STICK: Key.JOYSTICK_R_CLICK,
	JOY_BUTTON_A: Key.JOYSTICK_A,
	JOY_BUTTON_B: Key.JOYSTICK_B,
	JOY_BUTTON_X: Key.JOYSTICK_X,
	JOY_BUTTON_Y: Key.JOYSTICK_Y,
	JOY_BUTTON_DPAD_UP: Key.JOYSTICK_DPAD_UP,
	JOY_BUTTON_DPAD_DOWN: Key.JOYSTICK_DPAD_DOWN,
	JOY_BUTTON_DPAD_LEFT: Key.JOYSTICK_DPAD_LEFT,
	JOY_BUTTON_DPAD_RIGHT: Key.JOYSTICK_DPAD_RIGHT,
	JOY_BUTTON_START: Key.JOYSTICK_START,
	JOY_BUTTON_BACK: Key.JOYSTICK_SELECT,
	JOY_BUTTON_GUIDE: Key.JOYSTICK_HOME,
}

const MOUSE_BUTTON_MAP = {
	MOUSE_BUTTON_LEFT: Key.MOUSE_LEFT,
	MOUSE_BUTTON_RIGHT: Key.MOUSE_RIGHT,
	MOUSE_BUTTON_MIDDLE: Key.MOUSE_MIDDLE,
}

static func to_text(type: int) -> String:
	var index = Key.values().find(type)
	if index != -1:
		return Key.keys()[index]
	
	var ev = to_event(type) as InputEventKey
	if ev:
#		if ev.unicode:
#			var char = String.chr(ev.unicode)
#			if char == " ":
#				return "Space"
#			return char
		return ev.as_text()
	return ""


static func to_event(type: int) -> InputEvent:
	if type <= 0:
		var key = InputEventKey.new()
		var code = -type
		if code >= KEY_SPECIAL:
			key.keycode = code
		else:
			if code >= 97 and code <= 122: # lower case a-z
				code -= 32 # make it upper case to match keycode
			key.unicode = code
			key.keycode = code
		key.pressed = true
		return key
		
	if type >= Key.JOYSTICK_L_UP and type <= Key.JOYSTICK_R_LEFT:
		var values = JOY_MOTION_MAP.get(type)
		if values:
			var joypad = InputEventJoypadMotion.new()
			joypad.axis = values[0]
			joypad.axis_value = values[1]
			return joypad
	
	if type >= Key.MOUSE_LEFT and type <= Key.MOUSE_MIDDLE:
		var idx = MOUSE_BUTTON_MAP.values().find(type)
		if idx != -1:
			var mouse = InputEventMouseButton.new()
			mouse.button_index = MOUSE_BUTTON_MAP.keys()[idx]
			return mouse
	
	if type >= Key.JOYSTICK_START and type <= Key.JOYSTICK_SELECT:
		var idx = JOY_BUTTON_MAP.values().find(type)
		if idx != -1:
			var joy_button = InputEventJoypadButton.new()
			joy_button.button_index = JOY_BUTTON_MAP.keys()[idx]
			return joy_button
	
	return null
	
static func to_type(event: InputEvent) -> int:
	if event is InputEventKey:
		if event.unicode: # ASCII should only return unicodes ?
			return -event.unicode
		
		return -event.keycode # Special Keys like Enter, Tab should only have keycode ?
	
	if event is InputEventJoypadMotion and event.axis_value != 0:
		for key in JOY_MOTION_MAP:
			var value = JOY_MOTION_MAP.get(key)
			var positive = value[1] > 0
			if event.axis == value[0] and ((positive and event.axis_value > 0) or (not positive and event.axis_value < 0)):
				return key
	elif event is InputEventJoypadButton and JOY_BUTTON_MAP.has(event.button_index):
		return JOY_BUTTON_MAP.get(event.button_index)
	elif event is InputEventMouseButton and MOUSE_BUTTON_MAP.has(event.button_index):
		return MOUSE_BUTTON_MAP.get(event.button_index)
	
	return 1


static func is_empty(ev: InputEvent) -> bool:
	return ev is InputEventJoypadMotion and abs(ev.axis_value) <= 0.5

static func is_joypad(ev: InputEvent) -> bool:
	return ev is InputEventJoypadMotion or ev is InputEventJoypadButton
