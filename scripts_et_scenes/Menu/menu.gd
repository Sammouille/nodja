extends CanvasLayer


@onready var VBoxChoice = $Control/VBoxChoice
@onready var VBoxCredits = $Control/VBoxCredits
@onready var Options = $Options

@export var tab_menu_hide_show : Array[Node]


func _ready() -> void:
	#TranslationServer.set_locale("eng")
	pass


func show_node(node) -> void:
	for i in tab_menu_hide_show:
		i.visible = false
	node.visible = true


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts_et_scenes/Main/Main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_option_pressed() -> void:
	show_node(Options)


func _on_options_back_option() -> void:
	show_node(VBoxChoice)


func _on_credits_pressed() -> void:
	show_node(VBoxCredits)


func _on_back_credits_pressed() -> void:
	show_node(VBoxChoice)
