extends Node2D

## Scène trouvable dans scripts_et_scenes/Manege/Chargements. Modifiable à souhait.
@export var ecran_de_chargement : Control

@export var garage: Node2D
@export var tilemaps : Node2D

@onready var jantes := garage.get_child(0)

@export var camera : Camera2D
@export var cam_distance_y := 1350
var dist_moyenne_voiture_cam_x


## Pour rajouter des nouvelles villes, mettre ici une variable nommée :
## "chemin_fichier_<nom_de_la_ville>", et lui donner le chemin dans le projet 
## de la scène associée
var chemin_fichier_postmodernite = "res://scripts_et_scenes/Manege/Zone/postmodernite.tscn"
var chemin_fichier_bidonville = "res://scripts_et_scenes/Manege/Zone/bidonville.tscn"
var chemin_fichier_modernite_ancree = "res://scripts_et_scenes/Manege/Zone/modernite_ancree.tscn"
var chemin_fichier_manifestations = "res://scripts_et_scenes/Manege/Zone/manifestations.tscn"
var chemin_fichier_revolution_joyeuse = "res://scripts_et_scenes/Manege/Zone/revolution_joyeuse.tscn"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Permet d'avoir la caméra un peu décalé en fonction de la voiture.
	dist_moyenne_voiture_cam_x = jantes.position.x - camera.position.x
	
	## Connecte l'échelle des objets aux changements de résolutions. (n'est pas encore utilisé).
	ManagerResolution.adapt_res_scale.connect(adapt_display.bind())
	
	chargement_disparait()
	
	## Connectes les fonctions de tilemaps et de ces obstacles avec des fonctions dans ce script.
	tilemaps.zone_de_chargement.load_zone.connect(charge_ville_suivante.bind())
	tilemaps.vers_couche.connect(change_camera_height.bind())
	for m in tilemaps.asperite_hitbox:
		m.body_entered.connect(asperites_collision.bind())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	actualiser_camera()

## S'assurer de la bonne taille de l'écran si la résolution change. Pas encore utilisé.
## TODO : S'assurer que les mini-jeux fonctionnent bien aussi avec les changements de résolutions. 
func adapt_display(scale_adapte):
	self.scale = Vector2(scale_adapte,scale_adapte)

## Appelé quand la voiture entre dans une zone de chargement
func charge_ville_suivante():
	var scene_charge
	var chemin_fichier
	
	## Attends que la transition au noir apparaisse.
	await chargement_apparait()
	
	## Assigne une ville à charger en fonction de la ville actuelle.
	match tilemaps.nom_ville :
		"Postmodernite":
			chemin_fichier = chemin_fichier_bidonville
		"Bidonville":
			chemin_fichier = chemin_fichier_modernite_ancree
		"Moderniteancree":
			chemin_fichier = chemin_fichier_manifestations
		"Manifestations":
			chemin_fichier = chemin_fichier_revolution_joyeuse
		"Revolutionjoyeuse":
			chemin_fichier = chemin_fichier_postmodernite
			
	## Retire la ville actuelle.
	tilemaps.queue_free()
	
	## Charge et fait apparaitre la nouvelle ville.
	scene_charge = load(chemin_fichier)
	tilemaps = scene_charge.instantiate()
	add_child(tilemaps)
	
	## Retire l'écran de chargement.
	chargement_disparait()
	
	## Connectes les fonctions entre elles et s'assure que la voiture commece à 0 vitesse et à la position par défaut.
	tilemaps.zone_de_chargement.load_zone.connect(charge_ville_suivante.bind())
	tilemaps.vers_couche.connect(change_camera_height.bind())
	jantes.position = Vector2.ZERO
	jantes.velocite = Vector2.ZERO
	for m in tilemaps.asperite_hitbox:
		m.body_entered.connect(asperites_collision.bind())
			
## Quand on passe dans une zone de chargement, on fait apparaître l'écran de chargement.
func chargement_apparait() -> void:
	var tween_chargement = get_tree().create_tween()
	tween_chargement.tween_property(ecran_de_chargement,"modulate:a",1.0,1.0)
	await tween_chargement.finished
	return

## Quand on le chargement d'une nouvelle ville est fini, on fait disparaître l'écran de chargement.
func chargement_disparait() -> void:
	var tween_chargement = get_tree().create_tween()
	tween_chargement.tween_property(ecran_de_chargement,"modulate:a",0.0,1.0)

## Change la hauteur de la caméra par rapport à la ville.
func change_camera_height(hauteur_ville):
	var cam_tween = get_tree().create_tween()
	cam_tween.tween_property(camera,"position:y",hauteur_ville - cam_distance_y,1.0)

## S'assure que la caméra suit la voiture.
func actualiser_camera():
	camera.position.x = jantes.position.x - dist_moyenne_voiture_cam_x
	
## Envoie à jantes comment changer sa vitesse.
func asperites_collision(useless):
	if jantes.jumping :
		jantes.changer_vitesse(+1)
	else : 
		jantes.changer_vitesse(-1)
