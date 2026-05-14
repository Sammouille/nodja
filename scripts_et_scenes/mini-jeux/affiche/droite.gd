extends TextureRect

var is_mouse_in : bool = false

var mouse_drag_pos : Vector2 = Vector2(0.0, 0.0)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("clique_gauche"):
		if is_mouse_in:
			mouse_drag_pos = get_viewport().get_mouse_position()
			#print(mouse_drag_pos)
	
	if is_mouse_in and Input.is_action_pressed("clique_gauche") and event is InputEventMouseMotion:
		var temp_current_mouse_pos = get_viewport().get_mouse_position()
		var temp_x = ( abs(mouse_drag_pos.x) - abs(temp_current_mouse_pos.x) ) * (  abs(temp_current_mouse_pos.x) / temp_current_mouse_pos.x )
		var temp_y = ( abs(mouse_drag_pos.y) - abs(temp_current_mouse_pos.y) ) * (  abs(temp_current_mouse_pos.y) / temp_current_mouse_pos.y )
		mouse_drag_pos = temp_current_mouse_pos
		
		position.x += temp_x *-1
		position.y += temp_y *-1
		

func _on_mouse_entered() -> void:
	#print("mouse in")
	is_mouse_in = true


func _on_mouse_exited() -> void:
	#print("mouse out")
	is_mouse_in = false
