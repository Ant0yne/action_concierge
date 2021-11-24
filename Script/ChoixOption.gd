extends Node

var souris_visible = bool(true)

func _souris_capture():
	if souris_visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		souris_visible = false
		print(souris_visible)
	if souris_visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		souris_visible = true
		print(souris_visible)
