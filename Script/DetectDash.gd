extends Area2D

onready var timerDash = $TimerDash

var dash = null

func _dash_possible():
	return dash != null

func _on_DetectDash_body_entered(body):
	dash = body

func _on_DetectDash_body_exited(body):
	dash = null
