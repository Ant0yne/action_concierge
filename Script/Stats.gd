extends Node

export var max_vie = int(1)
onready var vie = int(max_vie) setget set_vie

signal vie_zero

func set_vie(valeur):
	vie = valeur
	if vie <= 0:
		emit_signal("vie_zero")
