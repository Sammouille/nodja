extends CanvasLayer


@onready var VBoxChoice = $Control/VBoxChoice
@onready var VBoxCredits = $Control/VBoxCredits
@onready var Options = $Options

#Tableau regroupant chaque sous menu.
@export var tab_menu_hide_show : Array[Node]


func _ready() -> void:
	#TranslationServer.set_locale("eng")
	pass


#Fonction qui permet d'afficher un sous menu en cachant les autres.
func show_node(node) -> void:
	for i in tab_menu_hide_show:
		i.visible = false
	node.visible = true


#Quand le bouton Play est cliqué, lance la scène Main.
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts_et_scenes/Main/Main.tscn")


#Fonction relié à un Button permettant de quitter le jeu.
func _on_quit_pressed() -> void:
	get_tree().quit()


#Fonction relié à un Button permettant d'afficher le sous menu des Options.
func _on_option_pressed() -> void:
	show_node(Options)


#Fonction relié à un Button permettant de quitter les options et réafficher les boutons menu.
func _on_options_back_option() -> void:
	show_node(VBoxChoice)


#Fonction relié à un Button permettant d'afficher les credits.
func _on_credits_pressed() -> void:
	show_node(VBoxCredits)


#Fonction relié à un Button permettant de quitter les credits et réafficher les boutons menu.
func _on_back_credits_pressed() -> void:
	show_node(VBoxChoice)
