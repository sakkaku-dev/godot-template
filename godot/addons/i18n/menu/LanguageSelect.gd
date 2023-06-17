class_name LanguageSelect
extends OptionButton

const LANG_PREFIX = "LANG_"


func _ready():
	connect("item_selected", self._on_item_selected)

	var current_locale = TranslationServer.get_locale()
	var idx = _find_locale_index(current_locale)
	if idx == -1 and "_" in current_locale:
		var locale_without_country = current_locale.split("_")[0]
		idx = _find_locale_index(locale_without_country)

	if idx != -1:
		select(idx)


func _find_locale_index(locale: String) -> int:
	var locale_text = LANG_PREFIX + locale.to_upper()
	for i in range(0, get_item_count()):
		var item = get_item_text(i)

		if item == locale_text:
			return i

	return -1


func _on_item_selected(idx: int):
	var lang = get_item_text(idx)
	var locale = lang.substr(LANG_PREFIX.length())
	TranslationServer.set_locale(locale.to_lower())
