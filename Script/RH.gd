extends KinematicBody2D

const FORCE_RECUL = 150

onready var stats = $Stats

var recul = Vector2.ZERO

func _physics_process(delta):
	recul = recul.move_toward(Vector2.ZERO, 200 * delta)
	recul = move_and_slide(recul)

func creation_rh_effect():
	var RHEffect = load("res://Scenes/RHEffect.tscn")
	var rhEffect = RHEffect.instance()
	var main = get_tree().current_scene
	main.add_child(rhEffect)
	rhEffect.global_position = global_position

func _on_HurtBoxe_area_entered(area):
	recul = area.recul_vecteur * FORCE_RECUL
	stats.vie -= area.dommage

func _on_Stats_vie_zero():
	creation_rh_effect()
	queue_free()
