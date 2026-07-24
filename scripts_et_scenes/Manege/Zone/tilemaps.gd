extends Node2D
@export var parallax : Parallax2D

## Ct = Couche transition
@export var ct_couche_haute : Area2D
@export var ct_couche_milieu : Area2D
@export var ct_couche_basse : Node2D

@export var route : TileMapLayer

@export var zone_de_chargement : Area2D

var detection = load("res://scripts_et_scenes/Manege/Outils_Manege/detection_obstacle.tscn")

## Noms des villes, a modifier si on en rajoute.
@export_enum("Postmodernite","Bidonville","Moderniteancree","Manifestations","Revolutionjoyeuse") var nom_ville : String

var asperite_hitbox = []
signal vers_couche(hauteur_ville)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index_all_asperites = route.tile_set.get_source_count()
	var all_asperites_cells = []
	var all_asperites = []
	var i = route.tile_set.id_debut_tuile_obstacle
	
	parallax.scroll_offset.y = 0
	vers_couche.emit(ct_couche_haute.position.y)
	
	## Ces lignes mettent une hitbox au niveau de chaques obstacles. Ces hitboxs s'activeront en contacte avec la voiture,
	## et la ralentiront si elle est au sol ou l'accélèreront si elle est en l'air.
	
	## On récupère le nombre de tuile dans le tileset, et on va faire une récurrence while depuis le début des tuiles
	## obstacles jusqu'à leur fin.
	while i <=  route.tile_set.get_source_count() - 1 :
		## On rajoute à all_asperites_cells le tableau de toutes les cellules qui ont ce type d'obstacles.
		all_asperites_cells.append_array(route.get_used_cells_by_id(i))
		## On passe à l'obstacle suivant.
		i = i + 1
		
	## Pour toutes ces cellules, on va traduire leurs positions depuis la tilemap vers la position locale associée.
	for j in all_asperites_cells:
		all_asperites.append(route.map_to_local(j))
	
	## On instancie la hitbox des obstacles et on lui donne la position correspondante, au milieu de l'obstacle.
	for k in all_asperites :
		var asp_temp = detection.instantiate()
		route.add_child(asp_temp)
		asp_temp.position = k
		asperite_hitbox.append(asp_temp)


## Si la voiture descends, on fait descendre le parallax et on signale background_villes de changer la hauteur.
func _on_couches_milieu_body_entered(body: Node2D) -> void:

	if body.velocity.y > 0.0 :
		tween_parallax_scroll(ct_couche_basse.position.y - parallax.get_child(0).get_rect().size.y * parallax.get_child(0).scale.y)

		vers_couche.emit(ct_couche_basse.position.y)
	else : 
		tween_parallax_scroll(ct_couche_milieu.position.y - parallax.get_child(0).get_rect().size.y * parallax.get_child(0).scale.y)

		vers_couche.emit(ct_couche_milieu.position.y)


func _on_couches_haute_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		tween_parallax_scroll(ct_couche_milieu.position.y - parallax.get_child(0).get_rect().size.y * parallax.get_child(0).scale.y)

		vers_couche.emit(ct_couche_milieu.position.y)
	else : 
		tween_parallax_scroll(0)

		vers_couche.emit(ct_couche_haute.position.y)
		
## Si la voiture descend, on prends la position du noeud couche associé et on place le parallax à une distance
## juste au dessus du noeud égale à la taille de l'image. 
func tween_parallax_scroll(cible):
	var tween_para = get_tree().create_tween()
	tween_para.tween_property(parallax,"scroll_offset:y",cible,0.6)
