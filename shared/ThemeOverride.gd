extends Control

export var relative_font_size := 1.0
export var spacing := 0.0

var _original_font: Font


func _ready():
	_original_font = get_font("font")
	var font := _original_font.duplicate()
	
	if spacing != 0.0:
		font.set("extra_spacing_top", spacing)
		font.set("extra_spacing_bottom", spacing)

	set("custom_fonts/font", font)

	_update_font_size()


func _update_font_size():
	if relative_font_size != 1.0:
		var size = _original_font.get("size")
		if size:
			_get_font().set("size", size * relative_font_size)


func _get_font() -> Font:
	return get("custom_fonts/font")
