extends Node2D
@export var parallax : Parallax2D

## Ct = Couche transition
@export var ct_couche_haute : Area2D
@export var ct_couche_milieu : Area2D
@export var ct_couche_basse : Area2D

@export var route : TileMapLayer

@export var nom_ville : String
@export var zone_de_chargement : Area2D

const COUCHE_HAUTE = 0
const COUCHE_MILIEU = 1
const COUCHE_BASSE = 2

signal vers_couche(couche, hauteur_ville)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parallax.scroll_offset.y = 0
	print(parallax.get_child(0).get_rect().size * parallax.get_child(0).scale)
	vers_couche.emit(COUCHE_HAUTE,ct_couche_haute.position.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_couches_milieu_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		print("DESSOUS ")
		parallax.scroll_offset.y = ct_couche_milieu.position.y - parallax.get_child(0).get_rect().size.y
		vers_couche.emit()
	else : 
		print("DESSUS ")
		parallax.scroll_offset.y = 0.0


func _on_couches_haute_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0.0 :
		print("DESSOUS ")
		tween_parallax_scroll(ct_couche_milieu.position.y - parallax.get_child(0).get_rect().size.y * parallax.get_child(0).scale.y)

		vers_couche.emit(COUCHE_MILIEU,ct_couche_milieu.position.y)
	else : 
		print("DESSUS ")
		tween_parallax_scroll(0)

		vers_couche.emit(COUCHE_HAUTE,ct_couche_haute.position.y)


func _on_couches_basse_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func tween_parallax_scroll(cible):
	var tween_para = get_tree().create_tween()
	tween_para.tween_property(parallax,"scroll_offset:y",cible,0.6)
