extends TextureRect

#Variable pour vérifier si la souris est sur l'objet.
var is_mouse_in : bool = false

#Signal qui est relié avec l'inventaire et permet de faire apparaître un objet dans celui-ci.
signal go_inventaire(name : String)


func _ready() -> void:
	#Recherche l'inventaire dans l'arbre des objets.
	for i in get_tree().current_scene.get_children():
		if i.is_in_group("Inventaire"):
			#Connecte le signal à l'inventaire et à une méthode qui permet de faire apparaître des objets.
			connect("go_inventaire", i.get_child(0).on_signal_to_add_object_from_str)


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	#Si la souris est sur le scotch et que l'on clique, permet de faire apparaître un scotch dans l'inventaire.
	if is_mouse_in and Input.is_action_just_pressed("clique_gauche"):
		print("envoie dans l'inventaire")
		emit_signal("go_inventaire", "rouleau_scotch_inventaire")
		self.visible = false


#Si la souris est sur l'objet, met à jour la variable.
func _on_mouse_entered() -> void:
	is_mouse_in = true

#Si la souris n'est plus sur l'objet, met à jour la variable.
func _on_mouse_exited() -> void:
	is_mouse_in = false
