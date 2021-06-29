extends Node2D

const RH = preload("res://Scenes/RH.tscn")

var zone_creation_RH_X = int(1000)
var zone_creation_RH_Y = int(500)
var vecteur_cible


func _ready():
	_random_position()
	

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		var rh = RH.instance()
		rh.global_position = vecteur_cible
		add_child(rh)
		_random_position()
		
func _random_position():
	vecteur_cible = Vector2(rand_range(70, zone_creation_RH_X), rand_range(135, zone_creation_RH_Y))

