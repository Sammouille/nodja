extends Sprite2D

@export var fond_allume : Texture2D
@export var fond_eteint : Texture2D

func _ready() -> void: # prend la texture de fond éteint au lancement de la scène
	texture = fond_eteint
	
func _fond_allume(): # prend la texture de fond allumé quand toutes les lumières ont été allumées
	texture = fond_allume
