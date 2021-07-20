extends Node

export var max_vie = int(10)
onready var vie = int(max_vie) setget _set_vie

export var max_endu = int(100)
export var endu_vide = int(5)
onready var endu = int(max_endu) setget _set_endu

var mort = bool(false)
var position_perso

signal vie_zero
signal changement_vie(valeur)

signal endu_zero(valeur)
signal changement_endu(valeur)

func _set_vie(valeur):
	vie = valeur
	emit_signal("changement_vie", vie)
	if vie <= 0:
		emit_signal("vie_zero")

func _set_endu(valeur):
	endu = valeur
	emit_signal("changement_endu", endu)
	if endu <= 0:
		emit_signal("endu_zero", endu_vide)

	
