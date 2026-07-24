extends Control

#Tout les objets qui peuvent apparaître dans l'inventaire.
@onready var element_test = preload("res://scripts_et_scenes/Inventaire/element_test.tscn")
@onready var cle_voiture_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/cle_voiture_inventaire.tscn")
@onready var rouleau_scotch_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/rouleau_scotch_inventaire.tscn")
@onready var peluche_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/peluche_inventaire.tscn")
@onready var crayon_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/crayon_inventaire.tscn")
@onready var tampon_inventaire = preload("res://scripts_et_scenes/Inventaire/element_inventaire/tampon_inventaire.tscn")

#Dictionnaire reliant le nom de l'objet et l'objet à faire exister dans l'inventaire.
@onready var dict_str_obj = {
	"element_test" : element_test,
	"cle_voiture_inventaire" : cle_voiture_inventaire,
	"rouleau_scotch_inventaire" : rouleau_scotch_inventaire,
	"peluche_inventaire" : peluche_inventaire,
	"crayon_inventaire" : crayon_inventaire,
	"tampon_inventaire" : tampon_inventaire
}

#Tableau qui regroupe les zones de l'inventaire. Zone qui délimite l'inventaire, et donc où les objets peuvent apparaître etc.
@export var tab_inventary_zone : Array[ColorRect]

#Tableau des éléments actuellement existant dans l'inventaire.
@onready var tab_elements : Array

#Variable qui permet de savoir si la souris est en train de déplacer un objet de l'inventaire.
var is_draging : bool = false
#Variable qui sauvegarde l'objet actuellement en train d'être déplacer par la souris.
var element_drag = null

#Variable qui va permettre de faire de l'aléatoire.
var rng = RandomNumberGenerator.new()


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("debug_1"):
		#add_object(element_test)
		#on_signal_to_add_object_from_str("cle_voiture_inventaire")
	pass


#Fonction qui permet de faire apparaître un objet dans l'inventaire.
func add_object(object) -> void:
	#print("en train ajouter element")
	var tmp = object.instantiate()
	random_pos_in_inventary(tmp)
	self.add_child(tmp)
	tab_elements.append(tmp)
	#print("fini ajouter " + tmp.name)


#Fonction qui reçoit le signal d'ajouter <name> dans l'inventaire grâce au dictionnaire nom - objet.
@warning_ignore("shadowed_variable_base_class")
func on_signal_to_add_object_from_str(name : String):
	add_object(dict_str_obj[name])


#Fonction qui calcul une position aléatoire dans les limites de l'inventaire. Donne ensuite cette position à <object> qui est un objet existant dans l'inventaire.
func random_pos_in_inventary(object) -> void:
	var tmp_rng_zone = tab_inventary_zone.pick_random()
	var tmp_rng_x = rng.randi_range(tmp_rng_zone.global_position.x, tmp_rng_zone.global_position.x + tmp_rng_zone.size.x - object.size.x)
	var tmp_rng_y = rng.randi_range(tmp_rng_zone.global_position.y, tmp_rng_zone.global_position.y + tmp_rng_zone.size.y - object.size.y)
	
	object.global_position = Vector2(tmp_rng_x, tmp_rng_y)


#Fonction qui permet de savoir si <objet> est dans les limites de l'inventaire ou non.
func is_in_inventary(object) -> bool:
	var tmp_pos = object.global_position
	for i in tab_inventary_zone:
		if ( tmp_pos.x >= i.global_position.x and tmp_pos.x <= (i.global_position.x + i.size.x) ) and ( tmp_pos.y >= i.global_position.y and tmp_pos.y <= (i.global_position.y + i.size.y) ):
			return true
	return false


#Fonction qui permet de savoir si la position X <object_pos_x> est en dehors de la limite gauche de l'inventaire.
func is_out_left_inventary(object_pos_x) -> bool:
	if object_pos_x < tab_inventary_zone[0].global_position.x:
		return true
	return false


#Fonction qui permet de savoir si la position X <object_pos_x> est en dehors de la limite droite de l'inventaire.
func is_out_right_inventary(object_pos_x) -> bool:
	if object_pos_x > (tab_inventary_zone[2].global_position.x + tab_inventary_zone[2].size.x):
		return true
	return false


#Fonction qui permet de savoir si la position Y <object_pos_y> est en dehors de la limite haute de l'inventaire.
func is_out_up_inventary(object_pos_y) -> bool:
	if object_pos_y < 0:
		return true
	return false


#Fonction qui permet de savoir si la position Vector2 <object_pos> est en dehors de la limite basse de l'inventaire.
func is_out_down_inventary(object_pos : Vector2) -> bool:
	#for i in tab_inventary_zone:
		#if ( object_pos.x >= i.global_position.x and object_pos.x <= (i.global_position.x + i.size.x) ) and ( object_pos.y > (i.global_position.y + i.size.y) ):
			#return true
	for i in tab_inventary_zone:
		#Le "+ 10" est là pour marquer une marge.
		if object_pos.x > i.global_position.x + 10 and object_pos.x < i.global_position.x + i.size.x:
			if object_pos.y > i.global_position.y + i.size.y -10:
				return true
	return false


#Fonction qui permet de savoir si la position Vector2 <object_pos> est en dehors de l'inventaire au milieu, à droite des limites gauches.
func is_out_middle_left_inventary(object_pos : Vector2) -> bool:
	if object_pos.y > tab_inventary_zone[1].global_position.y + tab_inventary_zone[1].size.y:
		if object_pos.x > tab_inventary_zone[1].global_position.x :
			return true
	return false


#Fonction qui permet de savoir si la position Vector2 <object_pos> est en dehors de l'inventaire au milieu, à gauche des limites droites.
func is_out_middle_right_inventary(object_pos : Vector2) -> bool:
	if object_pos.y > tab_inventary_zone[1].global_position.y + tab_inventary_zone[1].size.y:
		if object_pos.x < tab_inventary_zone[1].global_position.x + tab_inventary_zone[1].size.x:
			return true
	return false
