extends AudioStreamPlayer

var timer: Timer

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(func(): super.play())

func play_debounce(time := 0.1):
	timer.start(time)
