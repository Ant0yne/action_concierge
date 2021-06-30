extends Node2D

const RH = preload("res://Scenes/RH.tscn")

var vecteur_cible
var nbre_rh = int(6)
var ajout_nbre_rh = int(3)
var nbre_vague = int(1)

func _ready():
	_random_position()

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		nbre_vague += 1
		nbre_rh += ajout_nbre_rh
		while get_child_count() <= nbre_rh:
			var rh = RH.instance()
			rh.global_position = vecteur_cible
			add_child(rh)
			_random_position()
		
func _random_position():
	vecteur_cible = Vector2(rand_range(80, 1065), rand_range(110, 520))

