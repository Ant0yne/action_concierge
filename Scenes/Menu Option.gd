extends Control

var choixOption = ChoixOption

var reset_focus_bouton = bool(false)

func _ready():
	self.visible = false
	reset_focus_bouton = false

func _process(delta):
	_focus_manette()
	
func _focus_manette():
	if self.visible == true and reset_focus_bouton == false:
		get_node("Quitter").grab_focus()
		reset_focus_bouton = true
	if self.visible == false and reset_focus_bouton == true:
		reset_focus_bouton = false

func _on_Quitter_button_up():
	self.visible = false

func _on_CheckBox_toggled(button_pressed):
	choixOption._souris_capture()


func _on_Taille_st_value_changed(value):
	choixOption.tailleST.size = value
	print(choixOption.tailleST.size)
