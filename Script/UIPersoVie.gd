extends Control

onready var label = $Label

var vie_max = int(4) setget _inst_vie_max
var vie = vie_max setget _change_vie

func _ready():
	self.vie_max = PersoStats.max_vie
	self.vie = PersoStats.vie
	PersoStats.connect("changement_vie", self, "_change_vie")

func _change_vie(valeur):
	vie = clamp(valeur, 0, vie_max)
	if label != null:
		label.text = "VIE =" + str(vie)
		
func _inst_vie_max(valeur):
	vie_max = max(valeur, 1)

