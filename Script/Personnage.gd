extends Area2D

export var vit := int(400)  # How fast the player will move (pixels/sec).
export var velo := int(1)
var taille_ecran  # Size of the game window.

func _ready():
	taille_ecran = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += velo
		velocity.UP
	if Input.is_action_pressed("ui_left"):
		velocity.x -= velo
	if Input.is_action_pressed("ui_down"):
		velocity.y += velo
	if Input.is_action_pressed("ui_up"):
		velocity.y -= velo
	if velocity.length() > 0:
		velocity = velocity.normalized() * vit
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, taille_ecran.x)
	position.y = clamp(position.y, 0, taille_ecran.y)
