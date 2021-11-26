extends AnimatedSprite

onready var richTextLabel = $RichTextLabel

var choixOption = ChoixOption

func _ready():
	if choixOption.st_sons == false :
		richTextLabel.visible = false
	connect("animation_finished", self,"_quand_animation_finie")
	frame = 0
	play("default")

func _quand_animation_finie():
	queue_free()
