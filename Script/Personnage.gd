extends KinematicBody2D

const ACCELERATION = int(25)
const VIT_MAX = int(250)
const FRICTION = int(20)
const DASH = int(5000)

var velocite = Vector2.ZERO

func _physics_process(delta):
	var input_vecteur = Vector2.ZERO
	input_vecteur.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vecteur.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vecteur = input_vecteur.normalized()
	
	if input_vecteur != Vector2.ZERO:
		velocite += input_vecteur * ACCELERATION * delta
		velocite = velocite.clamped(VIT_MAX * delta)
	else:
		velocite = velocite.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if Input.is_action_just_pressed("ui_dash"):
		print("salut c'est le dash")
		velocite += input_vecteur * DASH * delta
	
	move_and_collide(velocite)
