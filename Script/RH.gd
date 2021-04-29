extends KinematicBody2D

const RHEffetMort = preload("res://Scenes/RHEffetMort.tscn")

const FORCE_RECUL = int(350)
const ACCELERATION = int(100)
const VIT_MAX = int(50)
const FRICTION = int(600)

onready var stats = $Stats
onready var detectionPerso = $DetectionPerso
onready var animatedSprite = $AnimatedSprite

var velocite = Vector2.ZERO
var recul = Vector2.ZERO

enum {
	IDLE,
	MARCHE,
	CHASSE
}

var etat = CHASSE

func _physics_process(delta):
	recul = recul.move_toward(Vector2.ZERO, FRICTION * delta)
	recul = move_and_slide(recul)
	
	match etat :
		IDLE:
			velocite = velocite.move_toward(Vector2.ZERO, FRICTION * delta)
			_a_vu_perso()
		
		MARCHE:
			pass
		
		CHASSE:
			_chasse_perso(delta)
	
	velocite = move_and_slide(velocite)

func _a_vu_perso():
	if detectionPerso._voit_perso():
		etat = CHASSE

func _chasse_perso(delta):
	var perso = detectionPerso.perso
	if perso != null:
		var direction_perso = (perso.global_position - global_position).normalized()
		velocite = velocite.move_toward(direction_perso * VIT_MAX, ACCELERATION * delta)
	else:
		etat = IDLE
	animatedSprite.flip_h = velocite.x < 0

func creation_rh_effect():
	var rhEffetMort = RHEffetMort.instance()
	get_parent().add_child(rhEffetMort)
	rhEffetMort.global_position = global_position

func _on_HurtBoxe_area_entered(area):
	recul = area.recul_vecteur * FORCE_RECUL
	stats.vie -= area.dommage

func _on_Stats_vie_zero():
	creation_rh_effect()
	queue_free()
