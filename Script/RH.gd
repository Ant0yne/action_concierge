extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_attaque"):
		var RHEffect = load("res://Scenes/RHEffect.tscn")
		var rhEffect = RHEffect.instance()
		var main = get_tree().current_scene
		main.add_child(rhEffect)
		rhEffect.global_position = global_position
		queue_free()
