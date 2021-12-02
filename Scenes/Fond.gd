extends Sprite

onready var choixOption = ChoixOption

func _ready():
	if choixOption.fond_cache == true and self.visible :
		self.visible = false
		get_tree().set_group("Decor", "visible", false)
	if choixOption.fond_cache == false and !self.visible :
		self.visible = true
		get_tree().set_group("Decor", "visible", true)

func _process(delta):
	if choixOption.fond_cache == true and self.visible :
		self.visible = false
		get_tree().set_group("Decor", "visible", false)
	if choixOption.fond_cache == false and !self.visible :
		self.visible = true
		get_tree().set_group("Decor", "visible", true)
