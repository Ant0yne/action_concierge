extends KinematicBody2D

const ACCELERATION = int(500)
const VIT_MAX = int(250)
const FRICTION = int(600)
const VIT_DASH = int(600)

enum {
	MARCHE,
	DASH,
	ATTAQUE
}

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var etat = MARCHE
var velocite = Vector2.ZERO

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match etat:
		MARCHE:
			marche_etat(delta)
			
		DASH:
			dash_etat(delta)
			
		ATTAQUE:
			attaque_etat(delta)


func marche_etat(delta):
	var input_vecteur = Vector2.ZERO
	input_vecteur.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vecteur.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vecteur = input_vecteur.normalized()
	
	if input_vecteur != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vecteur)
		animationTree.set("parameters/Marche/blend_position", input_vecteur)
		animationTree.set("parameters/Attaque/blend_position", input_vecteur)
		animationState.travel("Marche")
		velocite = velocite.move_toward(input_vecteur * VIT_MAX, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocite = velocite.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if Input.is_action_just_pressed("ui_dash"):
		#velocite += input_vecteur * VIT_DASH * delta
		velocite = velocite.move_toward(input_vecteur * VIT_DASH, VIT_DASH)
	
	velocite = move_and_slide(velocite)
	
	if Input.is_action_just_pressed("ui_attaque"):
		etat = ATTAQUE
	
func dash_etat(delta):
	pass

func attaque_etat(delta):
	velocite = Vector2.ZERO
	animationState.travel("Attaque")
	
func animation_attaque_termine():
	etat = MARCHE







