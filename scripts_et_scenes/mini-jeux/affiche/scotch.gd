extends TextureRect

var is_mouse_in : bool = false

signal go_inventaire(name : String)


func _ready() -> void:
	for i in get_tree().current_scene.get_children():
		if i.is_in_group("Inventaire"):
			connect("go_inventaire", i.get_child(0).on_signal_to_add_object_from_str)


func _input(event: InputEvent) -> void:
	if is_mouse_in and Input.is_action_just_pressed("clique_gauche"):
		print("envoie dans l'inventaire")
		emit_signal("go_inventaire", "rouleau_scotch_inventaire")
		self.visible = false


func _on_mouse_entered() -> void:
	is_mouse_in = true


func _on_mouse_exited() -> void:
	is_mouse_in = false
