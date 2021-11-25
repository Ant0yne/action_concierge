extends Node

onready var tailleST = preload("res://Font/font_test.tres")

var souris_visible = bool(true)

func _souris_capture():
	if souris_visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		souris_visible = false
		print(souris_visible)
	elif souris_visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		souris_visible = true
		print(souris_visible)
