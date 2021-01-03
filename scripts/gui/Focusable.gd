extends Control

"""
Custom focusable control class, allows for multiple controls to be in focus
"""

class_name Focusable

var is_focused

func focus():
	is_focused = true

func unfocus():
	is_focused = false
