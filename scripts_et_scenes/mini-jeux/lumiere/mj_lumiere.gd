extends Node2D

signal lights_on

var nb_lumieres = 0
@export var photo_retouchee : PackedScene
@export var sprite_tampon_valide : Texture
@export var stream : Node

func _ready() -> void:
	for i in get_children():
		if i.is_in_group("lumiere"):
			i.light_clicked.connect(_on_light_clicked)

func _on_light_clicked():
	nb_lumieres += 1
	print("lumieres :" + str(nb_lumieres))
	if nb_lumieres >= 6:
		_turn_on_lights()
		
func _turn_on_lights():
	for i in get_tree().get_nodes_in_group("lumiere"):
		i.visible = false
	lights_on.emit()
	print("lumières allumées")
