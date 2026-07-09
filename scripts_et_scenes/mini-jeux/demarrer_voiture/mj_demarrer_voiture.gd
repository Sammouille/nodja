extends Control

#Variable modifiable dans l'éditeur, permet de changer les paramètres de base du mini jeu. Utile pour des tests et debug ou pour modifier les règles.
@export var has_scotch : bool = false
@export var has_key : bool = true

#Les positions limites que peut avoir la clé (gauche / droite).
@onready var PosPourTourner = $PosPourTourner
@onready var PosMax = $PosMax

@onready var Scotch = $Scotch
@onready var Cle = $Cle

#Variable modifiable depuis l'éditeur qui permettent d'ajuster les positions limites.
@export var modif_max_pos : int = 0
@export var modif_pos_pour_tourner : int = 0


func _ready() -> void:
	#On met à jour les positions limites.
	PosPourTourner.global_position.x += modif_pos_pour_tourner
	PosMax.global_position.x += modif_max_pos
	
	#Suivant les paramètres initiaux, le scotch ou la clé peuvent ou non être déjà affichés.
	if has_scotch:
		Scotch.visible = true
	else:
		Scotch.visible = false
	
	if has_key:
		Cle.visible = true
	else:
		Cle.visible = false


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	#touche de debug (F1 F2) pour ajouter les éléments comme si ils venaient de l'inventaire
	#Le scotch n'est ajouté que si la clé est bien positionnée.
	#if Input.is_action_just_pressed("debug_1") and Cle.is_on_good_pos:
		#put_scotch()
	#if Input.is_action_just_pressed("debug_2"):
		#put_key()
	pass


#Ajoute le scotch à la scène.
func put_scotch() -> void:
	has_scotch = true
	Scotch.visible = true


#Ajoute les clés à la scène.
func put_key() -> void:
	has_key = true
	Cle.visible = true


#Fonction appelé quand la souris est sur l'objet, donc là dans le minijeu.
func _on_mouse_entered() -> void:
	#Si la souris est en train de drag and drop la clé depuis l'inventaire, alors cela affiche la clé dans le minijeu.
	if Global.draging_element_inventaire == "cle_voiture_inventaire":
		put_key()
	
	#Si la souris est en train de drag and drop le scotch depuis l'inventaire, alors cela affiche le scotch dans le minijeu.
	if Global.draging_element_inventaire == "rouleau_scotch_inventaire":
		put_scotch()
