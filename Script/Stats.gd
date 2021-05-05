extends Node

export var max_vie = int(2)
onready var vie = int(max_vie) setget set_vie

signal vie_zero
signal changement_vie(valeur)

func set_vie(valeur):
	vie = valeur
	emit_signal("changement_vie", vie)
	if vie <= 0:
		emit_signal("vie_zero")
