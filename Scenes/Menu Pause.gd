extends Control

onready var menuOption = $"Menu Option"

func _ready():
	get_node("Reprendre").grab_focus()

func _process(delta):
	if Input.is_action_just_released("ui_passer"):
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible

func _on_Options_button_up():
	menuOption.visible = true

func _on_Reprendre_button_up():
	if self.visible == true :
		get_tree().paused = false
		self.visible = false
		menuOption.visible = false
