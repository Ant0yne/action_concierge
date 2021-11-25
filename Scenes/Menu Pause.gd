extends Control

onready var menuOption = $"Menu Option"

var reset_focus_bouton = bool(false)

func _ready():
	reset_focus_bouton = false

func _process(delta):
	if Input.is_action_just_released("ui_passer"):
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible
	_focus_manette()

func _focus_manette():
	if self.visible == true and reset_focus_bouton == false and menuOption.visible == false:
		get_node("Reprendre").grab_focus()
		reset_focus_bouton = true
	if self.visible == false and reset_focus_bouton == true:
		reset_focus_bouton = false
	if menuOption.visible == true and reset_focus_bouton == true:
		reset_focus_bouton = false

func _on_Options_button_up():
	menuOption.visible = true

func _on_Reprendre_button_up():
	if self.visible == true :
		get_tree().paused = false
		self.visible = false
		menuOption.visible = false
