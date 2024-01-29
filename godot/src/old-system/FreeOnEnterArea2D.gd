extends Area2D

@export var node: Node

func _ready():
	area_entered.connect(func(_a): node.queue_free())
	body_entered.connect(func(_a): node.queue_free())
