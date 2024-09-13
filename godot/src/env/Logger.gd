class_name Logger

const COLORS = {
	Level.ERROR: Color.RED,
	Level.WARN: Color.YELLOW,
	Level.INFO: Color.BLUE,
	Level.DEBUG: Color.GREEN,
}

enum Level {
	OFF,
	ERROR,
	WARN,
	INFO,
	DEBUG,
}

var name = ""

func _init(n: String):
	name = n

func info(msg: String):
	_log_for_level(Level.INFO, msg)

func warn(msg: String):
	_log_for_level(Level.WARN, msg)

func error(msg: String):
	_log_for_level(Level.ERROR, msg)

func debug(msg: String):
	_log_for_level(Level.DEBUG, msg)

func _log_for_level(level: int, msg: String):
	if level <= Env.log_level:
		var text = "[%s] [color=%s]%s[/color] %s: %s" % [_now(), COLORS[level].to_html(), Level.keys()[level], name, msg]
		print_rich(text)
		GameManager.logged.emit(text)

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
