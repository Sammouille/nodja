extends Control

@export var has_scotch : bool = false
@export var has_key : bool = true

@onready var Scotch = $Scotch
@onready var Cle = $Cle


func _ready() -> void:
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
	if Input.is_action_just_pressed("debug_1") and Cle.is_on_good_pos:
		put_scotch()
	if Input.is_action_just_pressed("debug_2"):
		put_key()


#ajoute le scotch à la scène
func put_scotch() -> void:
	has_scotch = true
	Scotch.visible = true


#ajoute les clés à la scène
func put_key() -> void:
	has_key = true
	Cle.visible = true
