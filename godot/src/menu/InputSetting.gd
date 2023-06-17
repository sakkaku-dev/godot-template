extends Control

const INPUT_SECTION = "input"

@export var actions: Array[String] = []

@onready var input_grid := $InputGrid
@onready var popup := $RemapKeyPopup

var _logger = Logger.new("InputSetting")
var _current_remap = null
var _action_button_map = {}

func _ready():
	popup.hide()
	for action in actions:
		var button = RemapButton.new()
		button.action = action
		_action_button_map[action] = button
		
		var ev = button.get_input()
		if ev == null:
			_logger.warn("No event for action %s" % action)
			continue
		
		var label = Label.new()
		label.text = action
		input_grid.add_child(label)
		
		button.connect("pressed", func(): _on_remap_pressed(button))
		input_grid.add_child(button)


func _input(ev: InputEvent):
	if _current_remap and not ev is InputEventMouseMotion:
		_current_remap.remap_input(ev)
		popup.hide()
		get_tree().set_input_as_handled()
		_current_remap = null

func _on_remap_pressed(btn: RemapButton):
	_current_remap = btn
	popup.show()


func load_settings(config: ConfigFile):
	for section in config.get_sections():
		if not section.begins_with(INPUT_SECTION + "."): continue
		
		for action in config.get_section_keys(section):
			var type = config.get_value(section, action)
			var button = _action_button_map[action]
			button.remap_input(InputType.to_event(type))


func save_settings(config: ConfigFile):
	var section = "%s.%s" % [INPUT_SECTION, "default"]
	for action in actions:
		var button = _action_button_map[action]
		var type = InputType.to_type(button.get_input())
		config.set_value(section, action, type)
