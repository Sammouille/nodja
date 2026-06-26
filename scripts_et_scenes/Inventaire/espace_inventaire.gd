extends Control


@onready var element_test = preload("res://scripts_et_scenes/Inventaire/element_test.tscn")
@onready var cle_voiture_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/cle_voiture_inventaire.tscn")
@onready var rouleau_scotch_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/rouleau_scotch_inventaire.tscn")

@onready var dict_str_obj = {
	"element_test" : element_test,
	"cle_voiture_inventaire" : cle_voiture_inventaire,
	"rouleau_scotch_inventaire" : rouleau_scotch_inventaire,
}

@export var tab_inventary_zone : Array[ColorRect]

@onready var tab_elements = []

var is_draging = false
var element_drag = null

var rng = RandomNumberGenerator.new()


func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("debug_1"):
		#add_object(element_test)
		#on_signal_to_add_object_from_str("cle_voiture_inventaire")
	pass


func add_object(object) -> void:
	#print("en train ajouter element")
	var tmp = object.instantiate()
	random_pos_in_inventary(tmp)
	self.add_child(tmp)
	tab_elements.append(tmp)
	#print("fini ajouter " + tmp.name)


func on_signal_to_add_object_from_str(name : String):
	add_object(dict_str_obj[name])


func random_pos_in_inventary(object) -> void:
	var tmp_rng_zone = tab_inventary_zone.pick_random()
	var tmp_rng_x = rng.randi_range(tmp_rng_zone.global_position.x, tmp_rng_zone.global_position.x + tmp_rng_zone.size.x - object.size.x)
	var tmp_rng_y = rng.randi_range(tmp_rng_zone.global_position.y, tmp_rng_zone.global_position.y + tmp_rng_zone.size.y - object.size.y)
	
	object.global_position = Vector2(tmp_rng_x, tmp_rng_y)


func is_in_inventary(object) -> bool:
	var tmp_pos = object.global_position
	for i in tab_inventary_zone:
		if ( tmp_pos.x >= i.global_position.x and tmp_pos.x <= (i.global_position.x + i.size.x) ) and ( tmp_pos.y >= i.global_position.y and tmp_pos.y <= (i.global_position.y + i.size.y) ):
			return true
	return false


func is_out_left_inventary(object_pos_x) -> bool:
	if object_pos_x < tab_inventary_zone[0].global_position.x:
		return true
	return false


func is_out_right_inventary(object_pos_x) -> bool:
	if object_pos_x > (tab_inventary_zone[2].global_position.x + tab_inventary_zone[2].size.x):
		return true
	return false


func is_out_up_inventary(object_pos_y) -> bool:
	if object_pos_y < 0:
		return true
	return false


func is_out_down_inventary(object_pos : Vector2) -> bool:
	#for i in tab_inventary_zone:
		#if ( object_pos.x >= i.global_position.x and object_pos.x <= (i.global_position.x + i.size.x) ) and ( object_pos.y > (i.global_position.y + i.size.y) ):
			#return true
	for i in tab_inventary_zone:
		if object_pos.x > i.global_position.x + 10 and object_pos.x < i.global_position.x + i.size.x:
			if object_pos.y > i.global_position.y + i.size.y -10:
				return true
	return false


func is_out_middle_left_inventary(object_pos : Vector2) -> bool:
	if object_pos.y > tab_inventary_zone[1].global_position.y + tab_inventary_zone[1].size.y:
		if object_pos.x > tab_inventary_zone[1].global_position.x :
			return true
	return false


func is_out_middle_right_inventary(object_pos : Vector2) -> bool:
	if object_pos.y > tab_inventary_zone[1].global_position.y + tab_inventary_zone[1].size.y:
		if object_pos.x < tab_inventary_zone[1].global_position.x + tab_inventary_zone[1].size.x:
			return true
	return false
