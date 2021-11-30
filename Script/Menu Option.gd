extends Control

onready var bouttonTailleST = $"Taille st"
onready var cacheSouris = $"Cache Souris"
onready var stSons = $"ST Sons"
onready var dialAuto = $"Dial Auto"
onready var musique = $Musique
onready var ambiance = $Ambiance
onready var sFX = $SFX

var choixOption = ChoixOption

const FRAME_ATTENTE = int(15)

var reset_focus_bouton = bool(false)
var frame_appuye = int(0)

func _ready():
	self.visible = false
	reset_focus_bouton = false
	bouttonTailleST.value = choixOption.tailleST.size
	musique.value = choixOption.musique_volume
	ambiance.value = choixOption.ambiance_volume
	sFX.value = choixOption.sfx_volume
	frame_appuye = 0
	if choixOption.souris_visible == false :
		cacheSouris.pressed = true
	if choixOption.souris_visible == true :
		cacheSouris.pressed = false
	if choixOption.st_sons == false :
		stSons.pressed = false
	if choixOption.st_sons == true :
		stSons.pressed = true
	if choixOption.passer_dialogue_auto == false :
		dialAuto.pressed = false
	if choixOption.passer_dialogue_auto == true :
		dialAuto.pressed = true

func _process(delta):
	_focus_manette()
	_temps_pad_press()
	
func _focus_manette():
	if self.visible == true and reset_focus_bouton == false:
		get_node("Quitter").grab_focus()
		reset_focus_bouton = true
	if self.visible == false and reset_focus_bouton == true:
		reset_focus_bouton = false

func _on_Quitter_button_up():
	self.visible = false

func _on_CheckBox_toggled(button_pressed):
	if cacheSouris.pressed == true :
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		choixOption.souris_visible = false
	if cacheSouris.pressed == false :
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		choixOption.souris_visible = true

func _on_Taille_st_value_changed(value):
	choixOption.tailleST.size = value

func _temps_pad_press():
	if Input.is_action_pressed("ui_dpad_droite"):
		frame_appuye += 1
		if frame_appuye >= FRAME_ATTENTE:
			if bouttonTailleST.has_focus():
				bouttonTailleST.value += 1
			if musique.has_focus():
				musique.value += 1
			if ambiance.has_focus():
				ambiance.value += 1
			if sFX.has_focus():
				sFX.value += 1
	if Input.is_action_just_released("ui_dpad_droite"):
		frame_appuye = 0

	if Input.is_action_pressed("ui_dpad_gauche"):
		frame_appuye += 1
		if frame_appuye >= FRAME_ATTENTE:
			if bouttonTailleST.has_focus():
				bouttonTailleST.value -= 1
			if musique.has_focus():
				musique.value -= 1
			if ambiance.has_focus():
				ambiance.value -= 1
			if sFX.has_focus():
				sFX.value -= 1
	if Input.is_action_just_released("ui_dpad_gauche"):
		frame_appuye = 0

func _on_ST_Sons_toggled(button_pressed):
	if stSons.pressed == true :
		choixOption.st_sons = true
	if stSons.pressed == false :
		choixOption.st_sons = false

func _on_Dial_Auto_toggled(button_pressed):
	if dialAuto.pressed == true :
		choixOption.passer_dialogue_auto = true
	if dialAuto.pressed == false :
		choixOption.passer_dialogue_auto = false

func _on_Musique_value_changed(value):
	choixOption.musique_volume = value

func _on_Ambiance_value_changed(value):
	choixOption.ambiance_volume = value

func _on_SFX_value_changed(value):
	choixOption.sfx_volume = value
