extends AnimatedSprite

onready var collisionShape2DCercle = $Area2D/CollisionShape2D
onready var cercleDonnee = CercleDonnees

func _process(delta):
	if animation == "Idle Rempli" && cercleDonnee.ennemi_zero == true && cercleDonnee.nbre_vague == 1:
		set_animation("Idle Abime 1")
		play()

	if animation == "Idle Abime 1" && cercleDonnee.ennemi_zero == true && cercleDonnee.nbre_vague == 2:
		set_animation("Idle Abime 2")
		play()
	
	if animation == "Idle Abime 2" && cercleDonnee.ennemi_zero == true && cercleDonnee.nbre_vague == 3:
		set_animation("Idle Detruit")
		play()

func _on_Area2D_body_entered(body):
	if animation == "Idle Vide":
		set_animation("Remplissage")
		play()
		
	if animation == "Idle Abime 1" && cercleDonnee.ennemi_zero == true:
		set_animation("Eclairage")
		play()
		cercleDonnee.eclairage_joue = true
		
	if animation == "Idle Abime 2" && cercleDonnee.ennemi_zero == true:
		set_animation("Eclairage")
		play()
		cercleDonnee.eclairage_joue = true

func _on_Cercle_animation_finished():
	if animation == "Remplissage":
		set_animation("Eclairage")
		play()
		cercleDonnee.eclairage_joue = true
	
	if animation == "Eclairage" && cercleDonnee.nbre_vague == 1:
		set_animation("Idle Rempli")
		play()
		
	if animation == "Eclairage" && cercleDonnee.nbre_vague == 2:
		set_animation("Idle Abime 1")
		play()

	if animation == "Eclairage" && cercleDonnee.nbre_vague == 3:
		set_animation("Idle Abime 2")
		play()
