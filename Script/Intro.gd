extends Node2D

var choixOption = ChoixOption

func _ready():
	var timeline = Dialogic.start("Intro")
	add_child(timeline)
	timeline.connect("dialogic_signal", self, 'signaux_dialogic')

func _process(delta):
	if Input.is_action_just_pressed("ui_passer"):
		get_tree().change_scene("res://Scenes/Main.tscn")

func signaux_dialogic(valeur):
	if valeur == "passer" :
		print("coucouuuuuu")
		var ev = InputEvent
		ev.type = InputEvent.JOYSTICK_BUTTON
		ev.button_index = JOY_SONY_X
		ev.pressed = true
		get_tree().input_event(ev)
