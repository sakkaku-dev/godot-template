extends GridContainer

class_name TableContainer

export(Array, String) var headers = []

var data = []

func _ready():
	columns = headers.size()
	clear()


func clear():
	for c in get_children():
		remove_child(c)
	add_row_label(headers)


func add_row_label(col_data: Array) -> void:
	var labels = []
	for c in col_data:
		var label = Label.new()
		label.text = str(c)
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		label.align = Label.ALIGN_CENTER
		labels.append(label)
	add_row(labels)


func add_row(col_data: Array) -> void:
	if col_data.size() > headers.size():
		print("Cannot add data. Too many columns")
		return
	
	for c in col_data:
		add_child(c)
	
	var missing_col = headers.size() - col_data.size()
	for i in range(0, missing_col):
		add_child(Control.new())
