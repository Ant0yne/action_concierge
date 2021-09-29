extends KinematicBody2D

const RHEffetMort = preload("res://Scenes/RHEffetMort.tscn")
const Projectile = preload("res://Scenes/Projectile.tscn")

const FORCE_RECUL = int(350)
const ACCELERATION = int(300)
const VIT_MAX = int(125)
const FRICTION = int(600)
const COLLISION = int(400)
const MIN_TEMPS_DEAMBULE = int(1)
const MAX_TEMPS_DEAMBULE = int(3)
const ECART_CIBLE_DEAMBULE = int(4)
const LATENCE_TIR = int(2)

onready var stats = $Stats
onready var detectionPerso = $DetectionPerso
onready var animatedSprite = $AnimatedSprite
onready var hurtBox = $HurtBoxe
onready var collisionDouce = $CollisionDouce
onready var deambuleControlle = $DeambuleControlle
onready var projectileTimer = $ProjectileTimer

var velocite = Vector2.ZERO
var recul = Vector2.ZERO

enum {
	IDLE,
	DEAMBULE,
	TIR,
}

var etat = TIR

func _ready():
	animatedSprite.set_animation("Idle")
	animatedSprite.set_frame(rand_range(0,7))
	etat = _choisis_etat_random([IDLE, DEAMBULE])

func _physics_process(delta):
	recul = recul.move_toward(Vector2.ZERO, FRICTION * delta)
	recul = move_and_slide(recul)
	
	match etat :
		IDLE:
			animatedSprite.set_animation("Idle")
			velocite = velocite.move_toward(Vector2.ZERO, FRICTION * delta)
			_a_vu_perso()
			
			if deambuleControlle._temps_restant() == 0:
				_reset_etat_timer()

		DEAMBULE:
			animatedSprite.set_animation("Marche")
			_a_vu_perso()
			if deambuleControlle._temps_restant() == 0:
				_reset_etat_timer()

			_acc_vers_point(deambuleControlle.position_cible, delta)

			if global_position.distance_to(deambuleControlle.position_cible) <= ECART_CIBLE_DEAMBULE:
				_reset_etat_timer()
		
		TIR:
			var perso = detectionPerso.perso
			if perso != null && projectileTimer.is_stopped():
				animatedSprite.set_animation("Tir")
				_tir_projectile(self.global_position.direction_to(perso.global_position))
			else:
				etat = IDLE
			animatedSprite.flip_h = velocite.x > 0
		

	if collisionDouce._en_collision():
		velocite += collisionDouce._recup_vecteur_pousse() * delta * COLLISION
	velocite = move_and_slide(velocite)

func _acc_vers_point(point, delta):
	var direction_perso = global_position.direction_to(point)
#	var direction_perso = (perso.global_position - global_position).normalized()
	velocite = velocite.move_toward(direction_perso * VIT_MAX, ACCELERATION * delta)
	animatedSprite.flip_h = velocite.x > 0
	
func _reset_etat_timer():
	etat = _choisis_etat_random([IDLE, DEAMBULE])
	deambuleControlle._go_temps_deambule(rand_range(MIN_TEMPS_DEAMBULE,MAX_TEMPS_DEAMBULE))

func _a_vu_perso():
	if detectionPerso._voit_perso():
		etat = TIR

func _tir_projectile(projectile_direction):
	if Projectile:
		var projectile = Projectile.instance()
		get_tree().current_scene.add_child(projectile)
		projectile.global_position = self.global_position
		
		var projectile_rotation = projectile_direction.angle()
		projectile.rotation = projectile_rotation
		
		projectileTimer.start(LATENCE_TIR)
	
func _choisis_etat_random(liste_etats):
	liste_etats.shuffle()
	return liste_etats.pop_front()

func _on_HurtBoxe_area_entered(area):
	recul = area.recul_vecteur * FORCE_RECUL
	stats.vie -= area.dommage
	hurtBox._creer_effet_touche()
	
func creation_rh_effect():
	var rhEffetMort = RHEffetMort.instance()
	get_parent().add_child(rhEffetMort)
	rhEffetMort.global_position = global_position

func _on_Stats_vie_zero():
	creation_rh_effect()
	queue_free()


