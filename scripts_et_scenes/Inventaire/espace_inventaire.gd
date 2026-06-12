extends Control


@onready var element_test = preload("res://scripts_et_scenes/Inventaire/element_test.tscn")

@export var tab_inventary_zone : Array[ColorRect]

@onready var tab_elements = []


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_1"):
		add_object(element_test)


func add_object(object) -> void:
	#print("en train ajouter element")
	var tmp = object.instantiate()
	self.add_child(tmp)
	tab_elements.append(object)
	#print("fini ajouter " + tmp.name)


func is_in_inventary(object) -> bool:
	var tmp_pos = object.global_position
	for i in tab_inventary_zone:
		if ( tmp_pos.x >= i.global_position.x and tmp_pos.x <= (i.global_position.x + i.size.x) ) and ( tmp_pos.y >= i.global_position.y and tmp_pos.y <= (i.global_position.y + i.size.y) ):
			return true
	return false


func is_out_left_inventary(object) -> bool:
	if object.global_position.x < 0:
		return true
	return false


func is_out_right_inventary(object) -> bool:
	if object.global_position.x > (tab_inventary_zone[1].global_position.x + tab_inventary_zone[1].size.x):
		return true
	return false


func is_out_up_inventary(object) -> bool:
	if object.global_position.y < 0:
		return true
	return false


func is_out_down_inventary(object) -> bool:
	var tmp_pos = object.global_position
	for i in tab_inventary_zone:
		if ( tmp_pos.x >= i.global_position.x and tmp_pos.x <= (i.global_position.x + i.size.x) ) and ( tmp_pos.y > (i.global_position.y + i.size.y) ):
			return true
	return false
