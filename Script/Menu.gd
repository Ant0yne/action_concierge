extends Node2D

onready var menuOption = $"Menu Option"

var reset_focus_bouton = bool(true)

func _ready():
	reset_focus_bouton = true
	get_node("Jouer").grab_focus()

func _process(delta):
	_focus_manette()

func _focus_manette():
	if menuOption.visible == false and reset_focus_bouton == false:
		get_node("Credit").grab_focus()
		reset_focus_bouton = true
	if menuOption.visible == true and reset_focus_bouton == true:
		reset_focus_bouton = false

func _on_Quitter_button_up():
	get_tree().quit()

func _on_Jouer_button_up():
	get_tree().change_scene("res://Scenes/Intro.tscn")

func _on_TextureButton_button_up():
	menuOption.visible = true
