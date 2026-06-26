extends Node2D

@export var ecran_de_chargement : Control
@export var garage: Node2D

@export var tilemaps : Node2D

@export var height_route_asphalt := 580.0
@onready var jantes := garage.get_child(0)

@export var camera : Camera2D
@export var cam_distance_y := 1350
var dist_moyenne_voiture_cam_x


## Pour rajouter des nouvelles villes, mettre ici une variable nommée :
## "chemin_fichier_<nom_de_la_ville>", et lui donner le chemin dans le projet 
## de la scène associée
var chemin_fichier_postmodernite = "res://scripts_et_scenes/Manege/postmodernite.tscn"
var chemin_fichier_bidonville = "res://scripts_et_scenes/Manege/bidonville.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dist_moyenne_voiture_cam_x = jantes.position.x - camera.position.x
	tilemaps.route.position.y = height_route_asphalt
	ManagerResolution.adapt_res_scale.connect(adapt_display.bind())
	chargement_disparait()
	tilemaps.zone_de_chargement.load_zone.connect(charge_ville_suivante.bind())
	tilemaps.vers_couche.connect(change_camera_height.bind())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	actualiser_camera()
	pass
	#if jantes.position.y >= route_asphalt.position.y:
		##parallax.scroll_offset.y = jantes.position.y - 580.0
		#var p_sc = jantes.hauteur_voiture.get_collision_point().y / height_route_asphalt
		#parallax.scale = Vector2(p_sc,p_sc)

func adapt_display(scale_adapte):
	self.scale = Vector2(scale_adapte,scale_adapte)

## Appelé quand la voiture entre dans une zone de chargement
func charge_ville_suivante():
	await chargement_apparait()
	var chemin_fichier
	match tilemaps.nom_ville :
		"Postmodernite":
			chemin_fichier = chemin_fichier_bidonville
		"Bidonville":
			chemin_fichier = chemin_fichier_bidonville
	tilemaps.queue_free()
	var scene_charge = load(chemin_fichier)
	tilemaps = scene_charge.instantiate()
	add_child(tilemaps)
	chargement_disparait()
	tilemaps.zone_de_chargement.load_zone.connect(charge_ville_suivante.bind())
	jantes.position = Vector2.ZERO
	jantes.velocite = Vector2.ZERO
			
## Quand on passe dans une zone de chargement, on fait apparaître l'écran de chargement
func chargement_apparait() -> void:
	var tween_chargement = get_tree().create_tween()
	tween_chargement.tween_property(ecran_de_chargement,"modulate:a",1.0,1.0)
	await tween_chargement.finished
	return

## Quand on le chargement d'une nouvelle ville est fini, on fait disparaître
## l'écran de chargement.
func chargement_disparait() -> void:
	var tween_chargement = get_tree().create_tween()
	tween_chargement.tween_property(ecran_de_chargement,"modulate:a",0.0,1.0)

func change_camera_height(couche,hauteur_ville):
	var cam_tween = get_tree().create_tween()
	cam_tween.tween_property(camera,"position:y",hauteur_ville - cam_distance_y,1.0)

func actualiser_camera():
	camera.position.x = jantes.position.x - dist_moyenne_voiture_cam_x
	
