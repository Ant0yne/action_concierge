extends Area2D

const VIT_MAX = int(100)

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += VIT_MAX * direction * delta

func _detruit():
	queue_free()
	
func _on_Projectile_area_entered(area):
	_detruit()

func _on_Projectile_body_entered(body):
	_detruit()

func _on_VisibilityNotifier2D_screen_exited():
	_detruit()
