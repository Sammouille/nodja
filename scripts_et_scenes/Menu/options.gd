extends CanvasLayer

@onready var ColorRectFond = $Control/ColorRectFond

@onready var ScrollGeneral = $ScrollGeneral
@onready var ScrollVideo = $ScrollVideo
@onready var ScrollSound = $ScrollSound

@onready var QuitMenu = $Control/VBoxOptions/QuitMenu
@onready var QuitGame = $Control/VBoxOptions/QuitGame

@export var tab_option_hide_show : Array[Node]

signal back_option

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
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
	if Input.is_action_just_pressed("Pause"):
		self.visible = !self.visible
		get_tree().paused = self.visible


func show_node(node) -> void:
	for i in tab_option_hide_show:
		i.visible = false
	node.visible = true


func _on_back_pressed() -> void:
	self.visible = false
	emit_signal("back_option")


func _on_window_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(1280,720))
	@warning_ignore("integer_division")
	var w_pos = DisplayServer.screen_get_position( 0 ) + DisplayServer.screen_get_size(0) /2 - DisplayServer.window_get_size() /2
	DisplayServer.window_set_position(w_pos)


func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_back_param_pressed() -> void:
	for i in tab_option_hide_show:
		i.visible = false


func _on_general_pressed() -> void:
	show_node(ScrollGeneral)


func _on_video_pressed() -> void:
	show_node(ScrollVideo)


func _on_sound_pressed() -> void:
	show_node(ScrollSound)


func change_volume_bus(index, value):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
	
	if value == 0.0:
		AudioServer.set_bus_mute(index, true)
	elif value > 0.0 and AudioServer.is_bus_mute(index):
		AudioServer.set_bus_mute(index, false)


func _on_h_slider_general_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Master"), value )


func _on_h_slider_carnet_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Carnet"), value )


func _on_h_slider_ambiance_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Ambiance"), value )


func _on_h_slider_manege_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Manège"), value )


func _on_h_slider_mini_jeu_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Mini-Jeu"), value )


func _on_h_slider_inventaire_value_changed(value: float) -> void:
	change_volume_bus( AudioServer.get_bus_index("Inventaire"), value )


func _on_quit_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scripts_et_scenes/Menu/menu.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()
