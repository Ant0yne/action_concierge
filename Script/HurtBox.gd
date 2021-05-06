extends Area2D

const RHEffetTouche = preload("res://Scenes/RHEffetTouche.tscn")

onready var timer = $Timer
onready var collisionShape2D = $CollisionShape2D

#var invincible = bool(false) setget _set_invincible

#signal invicible_on
#signal invincible_off

#func _set_invincible(valeur):
#	invincible = valeur
#	if invincible == true:
#		emit_signal("invicible_on")
#	else :
#		emit_signal("invincible_off")

#func _start_invincible(duree):
#	self.invincible = true
#	timer.start(duree)
#
#func _on_Timer_timeout():
#	self.invincible = false

#func _on_HurtBoxe_invicible_on():
#	set_deferred("monitorable", false)
#
#func _on_HurtBoxe_invincible_off():
#	monitorable = true

func _start_invincible(duree):
	timer.start(duree)
	collisionShape2D.set_deferred("disabled", true)

func _on_Timer_timeout():
	collisionShape2D.disabled = false
	
func _dash_inv_on():
	collisionShape2D.set_deferred("disabled", true)

func _dash_inv_off():
	collisionShape2D.disabled = false
	
func _creer_effet_touche():
	var effet = RHEffetTouche.instance()
	var main = get_tree().current_scene
	main.add_child(effet)
	effet.global_position = global_position
