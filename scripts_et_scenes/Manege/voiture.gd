extends Node2D

@export var vitesse:= 0.4
@export var jantes: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y != jantes.position.y:
		position.y = lerpf(position.y, jantes.position.y, vitesse)
	else:
		position.y = jantes.position.y
	position.x = jantes.position.x

func _draw() -> void:
	draw_rect(Rect2(Vector2(-75,-50), Vector2(150,80)), Color(0.584, 0.396, 0.183, 1.0), true)
