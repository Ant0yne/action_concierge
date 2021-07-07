extends Control

onready var label = $Label
onready var textureProgress = $TextureProgress

var endu_max = int(100) setget _inst_endu_max
var endu = endu_max setget _change_endu

func _ready():
	self.endu_max = PersoStats.max_endu
	self.endu = PersoStats.endu
	PersoStats.connect("changement_endu", self, "_change_endu")
	textureProgress.max_value = endu_max

func _change_endu(valeur):
	endu = clamp(valeur, 0, endu_max)
	if label != null:
		label.text = str((endu*100)/endu_max) + "%"
	if textureProgress != null:
		textureProgress.value = endu
		
func _inst_endu_max(valeur):
	endu_max = max(valeur, 1)
