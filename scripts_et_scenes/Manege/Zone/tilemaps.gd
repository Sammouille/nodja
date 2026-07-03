extends Node2D
@export var parallax : Parallax2D

## Ct = Couche transition
@export var ct_couche_haute : Area2D
@export var ct_couche_milieu : Area2D
@export var ct_couche_basse : Area2D

@export var route : TileMapLayer

@export var nom_ville : String
@export var zone_de_chargement : Area2D

var detection = load("res://scripts_et_scenes/Manege/Outils_Manege/detection_obstacle.tscn")
const COUCHE_HAUTE = 0
const COUCHE_MILIEU = 1
const COUCHE_BASSE = 2

@export var nombre_tile_non_asperite := 2
var asperite_hitbox = []
signal vers_couche(couche, hauteur_ville)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index_all_asperites = route.tile_set.get_source_count()
	var all_asperites_cells = []
	var all_asperites = []
	var i = nombre_tile_non_asperite
	
	parallax.scroll_offset.y = 0
	vers_couche.emit(COUCHE_HAUTE,ct_couche_haute.position.y)
	
	while i <=  route.tile_set.get_source_count() - 1 :
		all_asperites_cells.append_array(route.get_used_cells_by_id(2))
		i = i + 1
	for j in all_asperites_cells:
		all_asperites.append(route.map_to_local(j))
	for k in all_asperites :
		var asp_temp = detection.instantiate()
		route.add_child(asp_temp)
		asp_temp.position = k
		asperite_hitbox.append(asp_temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_couches_milieu_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		print("DESSOUS ")
		parallax.scroll_offset.y = ct_couche_milieu.position.y - parallax.get_child(0).get_rect().size.y
		vers_couche.emit()
	else : 
		print("DESSUS ")
		parallax.scroll_offset.y = 0.0


func _on_couches_haute_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		print("DESSOUS ")
		tween_parallax_scroll(ct_couche_milieu.position.y - parallax.get_child(0).get_rect().size.y * parallax.get_child(0).scale.y)

		vers_couche.emit(COUCHE_MILIEU,ct_couche_milieu.position.y)
	else : 
		print("DESSUS ")
		tween_parallax_scroll(0)

		vers_couche.emit(COUCHE_HAUTE,ct_couche_haute.position.y)


func _on_couches_basse_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func tween_parallax_scroll(cible):
	var tween_para = get_tree().create_tween()
	tween_para.tween_property(parallax,"scroll_offset:y",cible,0.6)

func get_slowed(body):
	print("YOUPI DETECTEE")
	
