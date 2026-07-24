extends Node2D

signal lights_on

var nb_lumieres = 0 # stocke le nombrte de lumières allumées
@export var photo_retouchee : PackedScene
@export var sprite_tampon_valide : Texture
@export var stream : Node

func _ready() -> void:
	for i in get_children(): # se connecte aux signaux de toutes les lumières de la scène
		if i.is_in_group("lumiere"):
			i.light_clicked.connect(_on_light_clicked)

func _on_light_clicked(): # se lance quand une lumière est allumée (quand elle recoit le signal de
	nb_lumieres += 1
	print("lumieres :" + str(nb_lumieres))
	if nb_lumieres >= 6: # si toutes les lumières ont été allumées appelle la fonction d'allumage général
		_turn_on_lights() 
		
func _turn_on_lights():
	for i in get_tree().get_nodes_in_group("lumiere"): # récupère chaque lumière de la scène
		i.visible = false # cache les lumières
	lights_on.emit() # envoi ele signal pour changer le fond de la scène
	print("lumières allumées")
