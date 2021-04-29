extends Area2D

var perso = null

func _voit_perso():
	return perso != null

func _on_DetectionPerso_body_entered(body):
	perso = body

func _on_DetectionPerso_body_exited(body):
	perso = null
