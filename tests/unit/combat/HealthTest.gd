extends UnitTest


class TestHealthUsage:
	extends UnitTest
	var health: Health

	func before_each():
		health = autofree(Health.new())
		health.max_health = 5
		add_child(health)

	func test_initialize_health():
		assert_eq(health.health, 5)

	func test_reduce_health():
		health.reduce(2)
		assert_eq(health.health, 3)

	func test_increase_health():
		health.max_health = 10
		health.increase(3)
		assert_eq(health.health, 8)


class TestHealthSetterEmitter:
	extends UnitTest
	var health: Health

	func before_each():
		health = autofree(Health.new())
		watch_signals(health)

	func test_set_health():
		health.health = 2
		assert_eq(health.health, 2)

	func test_not_set_above_max_health():
		health.max_health = 5
		health.health = 10
		assert_eq(health.health, 5)

	func test_not_set_negative_health():
		health.health = -1
		assert_eq(health.health, 0)

	func test_emit_zero_health():
		health.health = 0
		assert_signal_emitted(health, "zero_health")

	func test_emit_health_changed():
		health.health = 2
		assert_signal_emitted_with_parameters(health, "health_changed", [2])

	func test_emit_health_changed_on_zero():
		health.health = 0
		assert_signal_emitted_with_parameters(health, "health_changed", [0])

	func test_set_max_health():
		health.max_health = 2
		assert_eq(health.max_health, 2)

	func test_not_set_max_health_below_one():
		health.max_health = 0
		assert_eq(health.max_health, 1)

	func test_emit_max_health_changed():
		health.max_health = 2
		assert_signal_emitted_with_parameters(health, "max_health_changed", [2])
