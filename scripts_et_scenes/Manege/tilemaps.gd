extends Node2D
@export var parallax : Parallax2D
@export var couches_dessus : Area2D
@export var couches_dessous : Area2D


@export var route_asphalt : TileMapLayer

@export var ville_hauteur_haute := -300.0
@export var ville_hauteur_milieu := 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parallax.scroll_offset.y = ville_hauteur_haute


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_couches_dessous_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		print("DESSOUS ")
		parallax.scroll_offset.y = 800.0
	else : 
		print("DESSUS ")
		parallax.scroll_offset.y = 0.0


func _on_couches_dessus_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		print("DESSOUS ")
		parallax.scroll_offset.y = ville_hauteur_milieu
	else : 
		print("DESSUS ")
		parallax.scroll_offset.y = ville_hauteur_haute
