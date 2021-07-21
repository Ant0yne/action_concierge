extends Camera2D

onready var perso = PersoStats

var valeur_zoom = Vector2(0.7,0.7)

func _ready():
	clear_current()

func _process(delta):
	if perso.mort == true:
		make_current()
		global_position = get_parent().global_position
		set_zoom(valeur_zoom)
		perso.mort = false
