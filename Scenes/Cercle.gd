extends AnimatedSprite

onready var collisionShape2DCercle = $Area2D/CollisionShape2D

func _on_Area2D_body_entered(body):
	if animation == "Idle Vide":
		set_animation("Remplissage")
		play()

func _on_Cercle_animation_finished():
	if animation == "Remplissage":
		set_animation("Eclairage")
		play()
