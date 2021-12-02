extends ViewportContainer

onready var choixOption = ChoixOption

var luminosite

func _ready():
	self.material.set_shader_param("brightness", choixOption.luminosite)
	luminosite = self.material.get_shader_param("brightness")

func _process(delta):
	if luminosite != choixOption.luminosite :
		self.material.set_shader_param("brightness", choixOption.luminosite)

