extends AudioStreamPlayer2D

onready var musique = $Musique

onready var choixOption = ChoixOption

func _ready():
	musique.volume_db = choixOption.musique_volume
	self.volume_db = choixOption.ambiance_volume

func _process(delta):
	if musique.volume_db != choixOption.musique_volume:
		musique.volume_db = choixOption.musique_volume
	if self.volume_db != choixOption.ambiance_volume :
		self.volume_db = choixOption.ambiance_volume
