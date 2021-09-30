extends Node2D

onready var infobulle = $Infobulle
onready var trousse = $Trousse
onready var label = $Label
onready var area2D = $Area2D
onready var persoStats = PersoStats

const SOIN_MAX = int(10)
onready var soin_restant = int(SOIN_MAX)

var trousse_ouverte = bool(false)

func _ready():
	trousse.set_animation("default")
	infobulle.set_visible(false)
	label.set_visible(false)
	label.text = str(soin_restant)
	trousse_ouverte = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_soin") && trousse_ouverte == true && soin_restant > 0 && persoStats.vie < persoStats.max_vie:
			soin_restant -= 1
			persoStats.vie += 1
			label.text = str(soin_restant)

func _on_Area2D_body_entered(body):
	trousse.set_animation("ouvert")
	infobulle.set_visible(true)
	label.set_visible(true)
	trousse_ouverte = true

func _on_Area2D_body_exited(body):
	trousse.set_animation("default")
	infobulle.set_visible(false)
	label.set_visible(false)
	trousse_ouverte = false
