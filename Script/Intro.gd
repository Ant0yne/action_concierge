extends Node2D

func _ready():
	var timeline = Dialogic.start("Intro")
	add_child(timeline)
	timeline.connect("dialogic_signal", self, 'signaux_dialogic')

