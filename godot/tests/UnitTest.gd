class_name UnitTest
extends GutTest

func assert_contains_exact(arr: Array, items: Array):
	assert_eq(arr.size(), items.size())
	assert_contains_all(arr, items)

func assert_contains_all(arr: Array, items: Array):
	for i in items:
		assert_has(arr, i)
