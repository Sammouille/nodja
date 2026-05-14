extends TextureRect

#Variable qui permet de savoir si la souris survole la partie droite de l'affiche.
var is_mouse_in : bool = false

#Position actuelle de la souris pendant le drag.
var mouse_drag_pos : Vector2 = Vector2(0.0, 0.0)


func _input(event: InputEvent) -> void:
	#Vérifie l'input de drag.
	if Input.is_action_just_pressed("clique_gauche"):
		#Est-ce que la souris est sur l'affiche.
		if is_mouse_in:
			#Sauvegarde alors la position de la souris ce qui évite un décalage de position pour la suite.
			mouse_drag_pos = get_viewport().get_mouse_position()
			#print(mouse_drag_pos)
	
	#Si la souris drag l'affiche et qu'elle bouge, alors l'affiche bouge aussi.
	if is_mouse_in and Input.is_action_pressed("clique_gauche") and event is InputEventMouseMotion:
		#Récup de la position de la souris sur l'écran.
		var temp_current_mouse_pos = get_viewport().get_mouse_position()
		#On calcule la différence de position entre celle actuelle et la dernière enregistrée.
		var temp_x = ( abs(mouse_drag_pos.x) - abs(temp_current_mouse_pos.x) ) * (  abs(temp_current_mouse_pos.x) / temp_current_mouse_pos.x )
		var temp_y = ( abs(mouse_drag_pos.y) - abs(temp_current_mouse_pos.y) ) * (  abs(temp_current_mouse_pos.y) / temp_current_mouse_pos.y )
		#On enregistre l'actuelle.
		mouse_drag_pos = temp_current_mouse_pos
		
		#On déplace l'affiche.
		position.x += temp_x *-1
		position.y += temp_y *-1


#Est appelé quand la souris survole l'affiche.
func _on_mouse_entered() -> void:
	#print("mouse in")
	is_mouse_in = true


#Est appelé quand la souris ne survole plus l'affiche.
func _on_mouse_exited() -> void:
	#print("mouse out")
	is_mouse_in = false
