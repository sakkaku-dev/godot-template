@tool
class_name SpriteAnimTool
extends AnimationPlayer

@export var run: bool : set = execute

func update():
	pass

func execute(x):
	print("execute")
	if not Engine.is_editor_hint():
		print("SpriteAnimTool can only be run in the editor")
		return
	update()

func add_animation(builder: Builder) -> void:
	var name = builder.name
	var start_frame = builder.start_frame
	var end_frame = builder.end_frame
	var duration = builder.duration
	var loop = builder.loop
	var discrete = builder.discrete
	
	var node = builder.node
	var property = "frame"
	
	var lib = get_animation_library("")
	if lib == null:
		lib = AnimationLibrary.new()
		add_animation_library("", lib)
	
	var anim = Animation.new()
	if lib.has_animation(name):
		anim = lib.get_animation(name)
	else:
		lib.add_animation(name, anim)
		
	anim.loop_mode = loop
	anim.length = duration
	
	var sprite_path = String(owner.get_path_to(get_node(node))) + ":" + property
	var existing_track = anim.find_track(sprite_path, Animation.TYPE_VALUE)
	if existing_track != -1:
		anim.remove_track(existing_track)
		
	var track = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(track, sprite_path)
	if discrete:
		anim.value_track_set_update_mode(track, Animation.UPDATE_DISCRETE)
		
	var total_frames = (end_frame - start_frame) + 1

	var frames = builder.frames
	if frames.size() > 0:
		total_frames = frames.size()

	var frame_duration = duration / total_frames
	for i in range(0, total_frames):
		var frame = start_frame + i if frames.size() == 0 else frames[i]
		var key = anim.track_insert_key(track, frame_duration * i, i)
		anim.track_set_key_value(track, key, frame)
		

class Builder:
	var node = ""
	var name = ""
	var start_frame = 0
	var end_frame = 0
	var frames = []

	var duration = 1.0
	var loop = true
	var discrete = true
	
	func _init(node):
		self.node = node

	func setName(n: String):
		self.name = n
		return self
	
	func setRange(start: int, end: int):
		self.start_frame = start
		self.end_frame = end
		return self

	func setDuration(d: float):
		self.duration = d
		return self
	
	func setLoop(l: bool):
		self.loop = l
		return self

	func setDiscrete(d: bool):
		self.discrete = d
		return self
	
	func setFrames(f: Array):
		self.frames = f
		return self
