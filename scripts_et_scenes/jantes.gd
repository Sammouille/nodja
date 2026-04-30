extends Node2D


@export var poussee_horizontale:= 4.0
@export var poussee_verticale:= 30.0
@export var masse:= 1.0:
	set(value):
		inv_masse = 1.00/value
		masse = value
var inv_masse:= 1.0
@export var frottements_sol:= 0.1
@export var frottements_air:= 0.01

@export var gravite:= 9.8

var velocite:= Vector2.ZERO
var acceleration:= Vector2.ZERO

var au_sol:= false

const SOL = 500

func actualiser_velocite(delta: float):
	velocite += acceleration * delta
	acceleration = Vector2.ZERO
	position += velocite

func appliquer_force(force: Vector2):
	acceleration += force * inv_masse

func appliquer_impulsion(impulsion: Vector2):
	velocite += impulsion * inv_masse

func appliquer_frottements():
	if au_sol:
		appliquer_force(-velocite * frottements_sol)
	else:
		appliquer_force(-velocite * frottements_air)

func appliquer_gravite():
	if position.y < 500: 
		au_sol = false
		acceleration += Vector2(0.0, gravite * masse)
	else:
		if !au_sol:
			position.y = 500
			velocite.y = 0.0
		au_sol = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if au_sol:
		if Input.is_action_pressed("gauche") or Input.is_action_pressed("merde"):
			var trajectoire_horizontale:= Input.get_axis("gauche", "merde")
			appliquer_force(Vector2(trajectoire_horizontale * poussee_horizontale, 0.0))
		
		if Input.is_action_just_pressed("saut"):
			appliquer_impulsion(Vector2(0.0, -poussee_verticale))
	
	appliquer_gravite()
	appliquer_frottements()
	actualiser_velocite(delta)

func _draw() -> void:
	draw_circle(Vector2.RIGHT * 60 + Vector2.DOWN * 45, 20.0, Color(0.0, 0.0, 0.0, 1.0), true)
	draw_circle(Vector2.LEFT * 60 + Vector2.DOWN * 45, 20.0, Color(0.0, 0.0, 0.0, 1.0), true)
	
