extends Control

var choixOption = ChoixOption

func _ready():
	self.visible = false
	get_node("Quitter").grab_focus()
	
func _on_Quitter_button_up():
	self.visible = false

func _on_CheckBox_toggled(button_pressed):
	choixOption._souris_capture()
