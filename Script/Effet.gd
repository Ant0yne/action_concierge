extends AnimatedSprite

func _ready():
	connect("animation_finished", self,"_quand_animation_finie")
	frame = 0
	play("default")

func _quand_animation_finie():
	queue_free()
