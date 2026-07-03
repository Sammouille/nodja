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

@export var voiture_collision : CollisionShape2D

@export var  boost_vitesse := 600.0
@export var vitesse_x_max := 600.0
const SOL = 500
const VITESSE_PERPETUELLE = 100.0
const VITESSE_HORIZONTALE_MINIMALE = 10.0
var moteur_allume = false


func _ready() -> void:
	Global.je_suis_voiture_jante = self


func actualiser_velocite(delta: float):
	assurer_voiture_avance()
	velocite += acceleration * delta
	
	velocite.x = clamp(velocite.x,0.0,vitesse_x_max)
	acceleration = Vector2.ZERO
	velocity = velocite
	
func appliquer_force(force: Vector2):
	acceleration += force * inv_masse

func appliquer_impulsion(impulsion: Vector2):
	velocite += impulsion * inv_masse

func appliquer_frottements():
	if au_sol:
		appliquer_force(-velocite * frottements_sol)
	else:
		appliquer_force(-velocite * frottements_air)

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
	#if position.y < 500: 
		#au_sol = false
		#acceleration += Vector2(0.0, gravite * masse)
	#else:
		#if !au_sol:
			#position.y = 500
			#velocite.y = 0.0
		#au_sol = true
func assurer_voiture_avance():
	if velocite.x <= VITESSE_HORIZONTALE_MINIMALE and au_sol and moteur_allume:
		velocite.x = VITESSE_HORIZONTALE_MINIMALE
		appliquer_force(Vector2(VITESSE_PERPETUELLE,0.0))

func changer_vitesse(value):
	vitesse_x_max = clamp(vitesse_x_max + boost_vitesse * value,boost_vitesse, boost_vitesse * 20.0)
	if vitesse_x_max != boost_vitesse:
		appliquer_impulsion(Vector2(boost_vitesse * value,0.0))

func demarrer_voiture():
	moteur_allume = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if au_sol and moteur_allume:
		if Input.is_action_pressed("gauche") or Input.is_action_pressed("droite"):
			var trajectoire_horizontale:= Input.get_axis("gauche", "droite")
			appliquer_force(Vector2(trajectoire_horizontale * poussee_horizontale, 0.0))
		
		if Input.is_action_just_pressed("saut"): 
			jumped_once = true
			dynamic_gravite = 1000.0
			appliquer_impulsion(Vector2(0.0, -poussee_verticale))
		if Input.is_action_just_pressed("clique_gauche"):
			changer_vitesse(+1)
		
	appliquer_gravite(delta)
	appliquer_frottements()
	actualiser_velocite(delta)
	move_and_slide()

func _draw() -> void:
	pass
	#draw_circle(Vector2.RIGHT * 60 + Vector2.DOWN * 45, 20.0, Color(0.0, 0.0, 0.0, 1.0), true)
	#draw_circle(Vector2.LEFT * 60 + Vector2.DOWN * 45, 20.0, Color(0.0, 0.0, 0.0, 1.0), true)
	
