class_name Logger

var name = ""


func _init(n: String):
	name = n


func info(msg: String):
	_log_for_level(Debug.Level.INFO, msg)


func warn(msg: String):
	_log_for_level(Debug.Level.WARN, msg)


func error(msg: String):
	_log_for_level(Debug.Level.ERROR, msg)


func debug(msg: String):
	_log_for_level(Debug.Level.DEBUG, msg)


func trace(msg: String):
	_log_for_level(Debug.Level.TRACE, msg)


func _log_for_level(level: int, msg: String):
	if level <= Debug.log_level:
		var text = "[%s - %s]: %s" % [_now(), name, msg]
		print(text)
		Debug.print_line(text)


func _now() -> String:
	var dt = Time.get_datetime_dict_from_system()
	var year = dt["year"]
	var month = _leading_zero(dt["month"])
	var day = _leading_zero(dt["day"])
	var hour = _leading_zero(dt["hour"])
	var minute = _leading_zero(dt["minute"])
	var second = _leading_zero(dt["second"])
	return "%s-%s-%s %s:%s:%s" % [year, month, day, hour, minute, second]


func _leading_zero(num: int) -> String:
	if num < 10:
		return "0" + str(num)
	return str(num)
