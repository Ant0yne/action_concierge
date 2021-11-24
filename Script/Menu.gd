extends Node2D

onready var menuOption = $"Menu Option"

func _ready():
	get_node("Jouer").grab_focus()

func _on_Quitter_button_up():
	get_tree().quit()

func _on_Jouer_button_up():
	get_tree().change_scene("res://Scenes/Intro.tscn")

func _on_TextureButton_button_up():
	menuOption.visible = true
