extends UnitTest

const MAX_HP = 10

var hp: Health

func before_each():
    hp = Health.new()
    hp.max_health = MAX_HP
    add_child_autofree(hp)
    watch_signals(hp)

func test_start_with_health():
    assert_eq(hp.health, MAX_HP)

func test_deal_damage():
    hp.hurt(2)
    assert_eq(hp.health, 8)
    assert_signal_emitted_with_parameters(hp, 'health_changed', [8])

func test_deal_damage_not_below_zero():
    hp.hurt(100)
    assert_eq(hp.health, 0)

func test_emit_on_zero_health():
    assert_false(hp.is_dead())
    hp.hurt(100)
    assert_true(hp.is_dead())
    assert_signal_emitted(hp, 'zero_health')

func test_heal():
    hp.hurt(5)
    hp.heal(2)
    assert_eq(hp.health, 7)
    assert_signal_emitted_with_parameters(hp, 'health_changed', [7])

func test_not_heal_past_max_health():
    hp.hurt(5)
    assert_false(hp.is_full_health())

    hp.heal(100)
    assert_true(hp.is_full_health())
    assert_eq(hp.health, MAX_HP)

func test_get_health_percent():
    hp.hurt(2)
    assert_eq(hp.get_health_percent(), 0.8)