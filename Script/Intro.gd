extends Node2D

func _ready():
	var timeline = Dialogic.start("Intro")
	add_child(timeline)
	timeline.connect("dialogic_signal", self, 'signaux_dialogic')

func _process(delta):
	if Input.is_action_just_pressed("ui_passer"):
		get_tree().change_scene("res://Scenes/Main.tscn")
