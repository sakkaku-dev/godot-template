extends UnitTest

var tween: TweenEffect
var node: Node2D
var effect: FadeEffect


func before_each():
	tween = autofree(TweenEffect.new())

	node = Node2D.new()
	node.name = "TestNode"
	tween.add_child(node)

	effect = FadeEffect.new()
	effect.node_paths = [NodePath("../TestNode")]
	tween.add_child(effect)


func test_transition_to_original_value():
	tween.reverse = true
	add_child(tween)

	tween.start()
	assert_eq(node.modulate, Color.transparent)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.white)


func test_transition_from_original_value():
	add_child(tween)

	tween.start()
	assert_eq(node.modulate, Color.white)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.transparent)


func test_transition_multiple_times():
	add_child(tween)

	tween.start()
	assert_eq(node.modulate, Color.white)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.transparent)

	node.modulate = Color.red
	tween.start()
	assert_eq(node.modulate, Color.red)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.transparent)


func test_transition_run_only_once():
	add_child(tween)

	tween.start()
	tween.start()
	tween.start()
	tween.start()
	assert_eq(node.modulate, Color.white)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.transparent)


func test_initialize_with_transition_value():
	tween.reverse = true
	tween.initialize = true
	add_child(tween)

	assert_eq(node.modulate, Color.transparent)


func test_transition_with_initialize():
	tween.initialize = true
	add_child(tween)

	tween.start()
	assert_eq(node.modulate, Color.white)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.transparent)


func test_transition_delay():
	effect.delay = 0.5
	add_child(tween)

	tween.start()
	yield(yield_for(0.5), YIELD)
	assert_eq(node.modulate, Color.white)

	yield(yield_to(tween, "tween_all_completed", 3), YIELD)
	assert_eq(node.modulate, Color.transparent)


func test_transition_duration():
	effect.duration = 0.1
	add_child(tween)

	tween.start()

	yield(yield_for(0.11), YIELD)
	assert_eq(node.modulate.a, 0.0)
