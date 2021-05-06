extends Node2D

export var zone_deambule = int(32)

onready var positon_depart = global_position
onready var position_cible = global_position

onready var timer = $Timer

func _ready():
	_maj_position_cible()

func _maj_position_cible():
	var vecteur_cible = Vector2(rand_range(-zone_deambule, zone_deambule), rand_range(-zone_deambule, zone_deambule))
	position_cible = positon_depart + vecteur_cible
	
func _temps_restant():
	return timer.time_left

func _go_temps_deambule(duree):
	timer.start(duree)

func _on_Timer_timeout():
	_maj_position_cible()
