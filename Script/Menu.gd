extends Node2D

func _ready():
	get_node("Jouer").grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_Quitter_button_up():
	get_tree().quit()

func _on_Jouer_button_up():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_TextureButton_button_up():
	get_tree().change_scene("res://Scenes/Credit.tscn")
