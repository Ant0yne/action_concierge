extends Node2D

onready var timer = $Timer
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
		if choixOption.passer_dialogue_auto == true :
			timer.start(choixOption.temps_lecture)

#		var bouton = InputEvent
#		bouton.type = InputEvent.JOYSTICK_BUTTON
#		bouton.button_index = JOY_SONY_X
#		bouton.pressed = true
#		get_tree().input_event(bouton)


func _on_Timer_timeout():
	print("coucouuuuuu")
	var bouton = InputEventAction.new()
	bouton.action = "ui_accept"
	bouton.pressed = true
	Input.parse_input_event(bouton)
