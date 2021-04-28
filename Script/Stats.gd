extends Node

export var max_vie = 1
onready var vie = max_vie setget set_vie

signal vie_zero

func set_vie(valeur):
	vie = valeur
	if vie <= 0:
		emit_signal("vie_zero")
