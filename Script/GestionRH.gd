extends Node2D

onready var cercle = CercleDonnees

const RH = preload("res://Scenes/RH.tscn")
const RH2 = preload("res://Scenes/RH2.tscn")

var vecteur_cible
var nbre_rh = int(6)
var ajout_nbre_rh = int(3)
var rh
var rh2

func _ready():
	_random_position()

func _process(delta):
	if get_child_count() <= 0:
		cercle.ennemi_zero = true
	if cercle.eclairage_joue == true && get_child_count() <= 0 :
		cercle.ennemi_zero = false
		while get_child_count() <= nbre_rh:
			rh = RH.instance()
			rh.global_position = vecteur_cible
			add_child(rh)
			_random_position()
			rh2 = RH2.instance()
			rh2.global_position = vecteur_cible
			add_child(rh2)
			_random_position()
		cercle.eclairage_joue = false
		nbre_rh += ajout_nbre_rh
		cercle.nbre_vague += 1
		
	if cercle.game_over == true:
		for i in get_children():
			i.queue_free()
		
func _random_position():
	vecteur_cible = Vector2(rand_range(80, 1065), rand_range(110, 520))
