extends Control

@export var has_scotch : bool = false
@export var has_key : bool = true

@onready var PosPourTourner = $PosPourTourner
@onready var PosMax = $PosMax

@onready var Scotch = $Scotch
@onready var Cle = $Cle

@export var modif_max_pos : int = 0
@export var modif_pos_pour_tourner : int = 0


func _ready() -> void:
	PosPourTourner.global_position.x += modif_pos_pour_tourner
	PosMax.global_position.x += modif_max_pos
	
	if has_scotch:
		Scotch.visible = true
	else:
		Scotch.visible = false
	
	if has_key:
		Cle.visible = true
	else:
		Cle.visible = false


func _input(event: InputEvent) -> void:
	#touche de debug (F1 F2) pour ajouter les éléments comme si ils venaient de l'inventaire
	#Le scotch n'est ajouté que si la clé est bien positionnée.
	#if Input.is_action_just_pressed("debug_1") and Cle.is_on_good_pos:
		#put_scotch()
	#if Input.is_action_just_pressed("debug_2"):
		#put_key()
	pass


#ajoute le scotch à la scène
func put_scotch() -> void:
	has_scotch = true
	Scotch.visible = true


#ajoute les clés à la scène
func put_key() -> void:
	has_key = true
	Cle.visible = true


func _on_mouse_entered() -> void:
	if Global.draging_element_inventaire == "cle_voiture_inventaire":
		put_key()
	
	if Global.draging_element_inventaire == "rouleau_scotch_inventaire":
		put_scotch()
