extends KinematicBody2D

const ACCELERATION = int(500)
const VIT_MAX = int(250)
const FRICTION = int(600)
const VIT_DASH = int(1200)

enum {
	MARCHE,
	DASH,
	ATTAQUE
}

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var balaiHitbox = $Position2D/BalaiHitBox

var etat = MARCHE
var velocite = Vector2.ZERO
var dash_vecteur = Vector2.DOWN

func _ready():
	animationTree.active = true
	balaiHitbox.recul_vecteur = dash_vecteur
	animationTree.set("parameters/Idle/blend_position", Vector2.DOWN)
	animationTree.set("parameters/Attaque/blend_position", Vector2.DOWN)
	animationTree.set("parameters/Dash/blend_position", Vector2.DOWN)

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
		dash_vecteur = input_vecteur
		balaiHitbox.recul_vecteur = input_vecteur
		animationTree.set("parameters/Idle/blend_position", input_vecteur)
		animationTree.set("parameters/Marche/blend_position", input_vecteur)
		animationTree.set("parameters/Attaque/blend_position", input_vecteur)
		animationTree.set("parameters/Dash/blend_position", input_vecteur)
		animationState.travel("Marche")
		velocite = velocite.move_toward(input_vecteur * VIT_MAX, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocite = velocite.move_toward(Vector2.ZERO, FRICTION * delta)
	
	deplacement()

	if Input.is_action_just_pressed("ui_dash"):
		etat = DASH
	
	if Input.is_action_just_pressed("ui_attaque"):
		etat = ATTAQUE
	
func attaque_etat(delta):
	velocite = Vector2.ZERO
	animationState.travel("Attaque")
	
func dash_etat(delta):
	velocite = dash_vecteur * VIT_DASH
	animationState.travel("Dash")
	deplacement()
	
func deplacement():
	velocite = move_and_slide(velocite)
	
func animation_attaque_termine():
	etat = MARCHE

func animation_dash_termine():
	velocite = Vector2.ZERO
#	velocite = velocite * 0.8
	etat = MARCHE







