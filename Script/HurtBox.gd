extends Area2D

export var touche_visible = bool(true)

const RHEffetTouche = preload("res://Scenes/RHEffetTouche.tscn")

func _on_HurtBoxe_area_entered(area):
	if touche_visible:
		var effet = RHEffetTouche.instance()
		var main = get_tree().current_scene
		main.add_child(effet)
		effet.global_position = global_position
