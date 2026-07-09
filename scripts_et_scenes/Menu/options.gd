extends CanvasLayer

@onready var ColorRectFond = $Control/ColorRectFond

@onready var ScrollGeneral = $ScrollGeneral
@onready var ScrollVideo = $ScrollVideo
@onready var ScrollSound = $ScrollSound

@onready var QuitMenu = $Control/VBoxOptions/QuitMenu
@onready var QuitGame = $Control/VBoxOptions/QuitGame

@onready var OptionButtonLanguage = $ScrollGeneral/VBoxGeneral/VBoxLocalization/OptionButtonLanguage

#Tableau regroupant chaque sous menu.
@export var tab_option_hide_show : Array[Node]

#Signal connecté sur la scène Menu.
signal back_option


func _ready() -> void:
	#Quand le jeu se lance, met la fenêtre en plein écran et choisit la langue FR.
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	OptionButtonLanguage.select(0)
	
	#Suivant si la scène principale est le Menu ou Main, affiche ou non des éléments.
	if get_tree().current_scene.name == "Menu":
		ColorRectFond.visible = false
		QuitGame.visible = false
		QuitMenu.visible = false
	else:
		ColorRectFond.visible = true
		QuitGame.visible = true
		QuitMenu.visible = true


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	#Si la scène principale n'est pas Menu, alors appuyer sur ECHAP affiche la fenêtre des options, et met le jeu en pause.
	if get_tree().current_scene.name != "Menu" and Input.is_action_just_pressed("Pause"):
		self.visible = !self.visible
		get_tree().paused = self.visible


#Fonction qui permet d'afficher un sous menu en cachant les autres.
func show_node(node) -> void:
	for i in tab_option_hide_show:
		i.visible = false
	node.visible = true


#Fonction relié à un Button permettant de retourner au menu principal sur la scène Menu.
func _on_back_pressed() -> void:
	self.visible = false
	emit_signal("back_option")


#Fonction relié à un Button permettant de passer la fenêtre du jeu en mode Fenêtré avec une résolution de 1280x720 (redimensionnable). Met aussi au centre de l'écran la fenêtre du jeu.
func _on_window_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(1280,720))
	@warning_ignore("integer_division")
	var w_pos = DisplayServer.screen_get_position( 0 ) + DisplayServer.screen_get_size(0) /2 - DisplayServer.window_get_size() /2
	DisplayServer.window_set_position(w_pos)


#Fonction relié à un Button permettant de passer la fenêtre du jeu en mode Plein Ecran.
func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


#Fonction relié à un Button qui permet d'afficher le sous menu General des options.
func _on_general_pressed() -> void:
	show_node(ScrollGeneral)


#Fonction relié à un Button qui permet d'afficher le sous menu Video des options.
func _on_video_pressed() -> void:
	show_node(ScrollVideo)


#Fonction relié à un Button qui permet d'afficher le sous menu Audio des options.
func _on_sound_pressed() -> void:
	show_node(ScrollSound)


#Fonction qui permet de changer le volume sonore <value> d'un BUS audio <index>.
func change_volume_bus(index, value):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
	
	#Si la valeur à remplir est 0, alors le BUS audio devient muet. Sinon, il redevient audible.
	if value == 0.0:
		AudioServer.set_bus_mute(index, true)
	elif value > 0.0 and AudioServer.is_bus_mute(index):
		AudioServer.set_bus_mute(index, false)


#Relié à un HSlider, permet de changer le volume du BUS Master.
func _on_h_slider_general_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Master"), value )


#Relié à un HSlider, permet de changer le volume du BUS Carnet.
func _on_h_slider_carnet_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Carnet"), value )


#Relié à un HSlider, permet de changer le volume du BUS Ambiance.
func _on_h_slider_ambiance_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Ambiance"), value )


#Relié à un HSlider, permet de changer le volume du BUS Manège.
func _on_h_slider_manege_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Manège"), value )


#Relié à un HSlider, permet de changer le volume du BUS Mini-Jeu.
func _on_h_slider_mini_jeu_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Mini-Jeu"), value )


#Relié à un HSlider, permet de changer le volume du BUS Inventaire.
func _on_h_slider_inventaire_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Inventaire"), value )


#Fonction relié à un Button  qui permet depuis la scène Main de retourner à la scène Menu.
func _on_quit_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scripts_et_scenes/Menu/menu.tscn")


#Fonction relié à un Button qui permet de quitter le jeu.
func _on_quit_game_pressed() -> void:
	get_tree().quit()


#Fonction qui est relié à un OptionButton qui permet de choisir la langue du jeu.
func _on_option_button_language_item_selected(index: int) -> void:
	TranslationServer.set_locale(Global.dict_index_language[index])
