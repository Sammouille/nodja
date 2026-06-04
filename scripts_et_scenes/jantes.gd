extends CharacterBody2D


@export var poussee_horizontale:= 300.0
@export var poussee_verticale:= 900.0
@export var masse:= 1.0:
	set(value):
		inv_masse = 1.00/value
		masse = value
var inv_masse:= 1.0
@export var frottements_sol:= 0.1
@export var frottements_air:= 0.01

@export var gravite:= 980.0

var velocite:= Vector2.ZERO
var acceleration:= Vector2.ZERO

var au_sol:= false

@export var camera : Camera2D
@export var hauteur_voiture : RayCast2D

@export var voiture_collision : CollisionShape2D
const SOL = 500
const VITESSE_PERPETUELLE = 100.0
const VITESSE_HORIZONTALE_MINIMALE = 10.0

func actualiser_velocite(delta: float):
	assurer_voiture_avance()
	velocite += acceleration * delta
	
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

func actualiser_camera_zoom():
	pass


func appliquer_gravite():
	if !is_on_floor():
		acceleration += Vector2(0.0, gravite * masse)
		au_sol = false
	else :
		if !au_sol:
			velocite.y = 0.0
		au_sol = true
	#if position.y < 500: 
		#au_sol = false
		#acceleration += Vector2(0.0, gravite * masse)
	#else:
		#if !au_sol:
			#position.y = 500
			#velocite.y = 0.0
		#au_sol = true
func assurer_voiture_avance():
	if velocite.x <= VITESSE_HORIZONTALE_MINIMALE and au_sol:
		velocite.x = VITESSE_HORIZONTALE_MINIMALE
		appliquer_force(Vector2(VITESSE_PERPETUELLE,0.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if au_sol:
		if Input.is_action_pressed("gauche") or Input.is_action_pressed("droite"):
			var trajectoire_horizontale:= Input.get_axis("gauche", "droite")
			appliquer_force(Vector2(trajectoire_horizontale * poussee_horizontale, 0.0))
		
		if Input.is_action_just_pressed("saut"):
			appliquer_impulsion(Vector2(0.0, -poussee_verticale))
		
		
	appliquer_gravite()
	appliquer_frottements()
	actualiser_velocite(delta)
	actualiser_camera_zoom()
	move_and_slide()

func _draw() -> void:
	draw_circle(Vector2.RIGHT * 60 + Vector2.DOWN * 45, 20.0, Color(0.0, 0.0, 0.0, 1.0), true)
	draw_circle(Vector2.LEFT * 60 + Vector2.DOWN * 45, 20.0, Color(0.0, 0.0, 0.0, 1.0), true)
	
