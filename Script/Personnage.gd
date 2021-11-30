extends KinematicBody2D

const ACCELERATION = int(850)
const VIT_MAX = int(250)
const VIT_MIN = float(0.2)
const FRICTION = int(1200)
const VIT_DASH = int(1200)

const DEGATS = int(1)
const TPS_INVINCIBLE = int(2)

const ENDU_DASH = int(25)
const ENDU_ATT = int(10)
const ENDU_MARCHE = int(1)
const ENDU_IDLE = int(2)
const ENDU_LATENCE = int(2)

enum {
	MARCHE,
	DASH,
	ATTAQUE,
	MORT
}

onready var hitAudio = $Hit
onready var blessureAudio = $Blessure
onready var dashAudio = $Dash
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var animatedSprite = $AnimatedSprite
onready var balaiHitbox = $Position2D/BalaiHitBox
onready var stats = PersoStats
onready var hurtBox = $HurtBoxe
onready var timerEndu = $RecupEndu
onready var limiteDegat = $LimiteDegat
onready var gestionRH = CercleDonnees
onready var choixOption = ChoixOption

var etat = MARCHE
var velocite = Vector2.ZERO
var dash_vecteur = Vector2.DOWN
var endu_recup = bool(true)

func _ready():
	gestionRH.game_over = false
	randomize()
	stats.connect("vie_zero", self, "_mort_etat")
	stats.connect("endu_zero", self, "_recup_endu")
	animatedSprite.playing = true
	animationTree.active = true
	balaiHitbox.recul_vecteur = dash_vecteur
	animationTree.set("parameters/Idle/blend_position", Vector2.DOWN)
	animationTree.set("parameters/Attaque/blend_position", Vector2.DOWN)
	animationTree.set("parameters/Dash/blend_position", Vector2.DOWN)

func _physics_process(delta):
	_gestion_volume_son()
	match etat:
		MARCHE:
			_marche_etat(delta)
			
		DASH:
			dashAudio.play()
			_dash_etat(delta)
			
		ATTAQUE:
			if !hitAudio.playing :
				hitAudio.play()
			_attaque_etat(delta)
			
		MORT:
			pass

func _marche_etat(delta):
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
		if stats.endu < stats.max_endu && endu_recup == true :
			stats.endu += ENDU_MARCHE
		var ralentissement_endu = float(stats.endu) / float(stats.max_endu)
		ralentissement_endu = clamp(ralentissement_endu + VIT_MIN, VIT_MIN, 1)
		velocite = velocite.move_toward(input_vecteur * VIT_MAX  * ralentissement_endu, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		if stats.endu < stats.max_endu && endu_recup == true :
			stats.endu += ENDU_IDLE
		velocite = velocite.move_toward(Vector2.ZERO, FRICTION * delta)
	
	_deplacement()

	if Input.is_action_just_pressed("ui_dash"):
		if stats.endu > 1:
			etat = DASH
			stats.endu -= ENDU_DASH
			_recup_endu(ENDU_LATENCE)
	
	if Input.is_action_just_pressed("ui_attaque"):
		if stats.endu > 1:
			etat = ATTAQUE
			stats.endu -= ENDU_ATT
			_recup_endu(ENDU_LATENCE)
	
func _attaque_etat(delta):
	velocite = Vector2.ZERO
	animationState.travel("Attaque")
	
func _animation_attaque_termine():
	etat = MARCHE
	
func _dash_etat(delta):
	hurtBox._dash_inv_on()
	velocite = dash_vecteur * VIT_DASH
	animationState.travel("Dash")
	_deplacement()
	
func _animation_dash_termine():
	velocite = Vector2.ZERO
#	velocite = velocite * 0.8
	hurtBox._dash_inv_off()
	etat = MARCHE
	
func _deplacement():
	velocite = move_and_slide(velocite)

func _on_HurtBoxe_area_entered(area):
	blessureAudio.play()
	hurtBox._start_invincible(TPS_INVINCIBLE)
	limiteDegat.start(0.1)

func _on_LimiteDegat_timeout():
	limiteDegat.stop()
	stats.vie -= DEGATS
#	hurtBox._creer_effet_touche()

func _recup_endu(valeur):
	endu_recup = false
	if timerEndu.is_stopped():
#		print(valeur)
		timerEndu.start(valeur)
	if valeur == stats.endu_vide:
		timerEndu.stop()
		timerEndu.start(valeur)
		stats.endu = 1

func _on_RecupEndu_timeout():
	endu_recup = true
	
func _mort_etat():
	animationState.travel("Mort")
	etat = MORT
	gestionRH.game_over = true
	stats.position_perso = global_position
	stats.mort = true
	
func _animation_mort_terminee():
		get_tree().change_scene("res://Scenes/Menu.tscn")

func _gestion_volume_son():
	if hitAudio.volume_db != choixOption.sfx_volume :
		hitAudio.volume_db = choixOption.sfx_volume
	if blessureAudio.volume_db != choixOption.sfx_volume :
		blessureAudio.volume_db = choixOption.sfx_volume
	if dashAudio.volume_db != choixOption.sfx_volume :
		dashAudio.volume_db = choixOption.sfx_volume
