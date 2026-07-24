extends CharacterBody2D


@export var poussee_horizontale:= 300.0
@export var poussee_verticale:= 1000.0
@export var masse:= 1.0:
	set(value):
		inv_masse = 1.00/value
		masse = value
var inv_masse:= 1.0
@export var frottements_sol:= 0.1
@export var frottements_air:= 0.01

@export var gravite := 2000.0
var dynamic_gravite = gravite

var velocite:= Vector2.ZERO
var acceleration:= Vector2.ZERO

var au_sol:= false
var jumping := false
var jumped_once := false

@export var  boost_vitesse := 600.0
@export var vitesse_x_max := 600.0

const VITESSE_PERPETUELLE = 100.0
const VITESSE_HORIZONTALE_MINIMALE = 10.0
var moteur_allume = true


func _ready() -> void:
	Global.je_suis_voiture_jante = self

## Finalise le calcul de la vélocité, s'assure que la voiture ne va pas plus vite que la vitesse max horizontale.
func actualiser_velocite(delta: float):
	assurer_voiture_avance()
	velocite += acceleration * delta
	
	velocite.x = clamp(velocite.x,0.0,vitesse_x_max)
	acceleration = Vector2.ZERO
	velocity = velocite
	
	
## Utiliser pour appliquer une force à la voiture dans une direction (s'ajoute à la vitesse actuelle).
func appliquer_force(force: Vector2):
	acceleration += force * inv_masse

## Utiliser pour appliquer une impulsion directe à la voiture dans une direction (s'ajoute à la vitesse actuelle).
func appliquer_impulsion(impulsion: Vector2):
	velocite += impulsion * inv_masse

## Utiliser pour calculer des frotements lors du calcul de force (s'ajoute à la vitesse actuelle).
func appliquer_frottements():
	if au_sol:
		appliquer_force(-velocite * frottements_sol)
	else:
		appliquer_force(-velocite * frottements_air)

## Gère le saut, et la gravité de la voiture.
func appliquer_gravite(delta):
	if !is_on_floor():
		dynamic_gravite += dynamic_gravite * delta
		acceleration += Vector2(0.0, dynamic_gravite * masse)
		au_sol = false
		if jumped_once:
			jumping = true
			jumped_once = false
	else :
		if !au_sol:
			velocite.y = 0.0
			dynamic_gravite = gravite
		au_sol = true
		jumping = false

## Cette fonction s'assure que la voiture avance toujours, une fois qu'elle est allumée.
func assurer_voiture_avance():
	## Si la voiture a une très petite vitesse horizontale, est au sol, et peux avancer.
	if velocite.x <= VITESSE_HORIZONTALE_MINIMALE and au_sol and moteur_allume:
		velocite.x = VITESSE_HORIZONTALE_MINIMALE
		appliquer_force(Vector2(VITESSE_PERPETUELLE,0.0))

## Utiliser pour vitesse changer la vitesse de la voiture. 
## A chaque fois que l'on saute par dessus un obstacle, on accélère et notre vitesse maximum augmente. 
## A chaque fois que l'on se prends un obstacle, on perds de la vitesse max sans descendre en dessous du seuil normal.
func changer_vitesse(value):
	vitesse_x_max = clamp(vitesse_x_max + boost_vitesse * value,boost_vitesse, boost_vitesse * 20.0)
	if vitesse_x_max != boost_vitesse:
		appliquer_impulsion(Vector2(boost_vitesse * value,0.0))

## Appeler autre part pour dire que la voiture peut avancer après réparation du moteur.
func demarrer_voiture():
	moteur_allume = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	## Si voiture touche la route :
	if au_sol and moteur_allume:
		## Changer l'acceleration en fonction de l'appuie des touches.
		if Input.is_action_pressed("gauche") or Input.is_action_pressed("droite"):
			var trajectoire_horizontale:= Input.get_axis("gauche", "droite")
			appliquer_force(Vector2(trajectoire_horizontale * poussee_horizontale, 0.0))
		
		## Sauter si touche pressée.
		if Input.is_action_just_pressed("saut"): 
			jumped_once = true
			dynamic_gravite = 1000.0
			appliquer_impulsion(Vector2(0.0, -poussee_verticale))
		
	## Fonctions générales de gestions de la physique de la voiture.
	appliquer_gravite(delta)
	appliquer_frottements()
	actualiser_velocite(delta)
	move_and_slide()
