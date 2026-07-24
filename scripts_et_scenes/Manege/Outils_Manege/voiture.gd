extends Node2D

@export var vitesse:= 0.4
@export var jantes: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## Permet d'avoir l'effet où la voiture suit les pneus.
func _process(delta: float) -> void:
	if position.y != jantes.position.y:
		position.y = lerpf(position.y, jantes.position.y, vitesse)
	else:
		position.y = jantes.position.y
	position.x = jantes.position.x
