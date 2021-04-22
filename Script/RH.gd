extends Node2D

func creation_rh_effect():
	var RHEffect = load("res://Scenes/RHEffect.tscn")
	var rhEffect = RHEffect.instance()
	var main = get_tree().current_scene
	main.add_child(rhEffect)
	rhEffect.global_position = global_position



func _on_HurtBoxe_area_entered(area):
	creation_rh_effect()
	queue_free()
