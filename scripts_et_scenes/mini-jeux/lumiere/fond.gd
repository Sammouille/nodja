extends Sprite2D

@export var fond_allume : Texture2D
@export var fond_eteint : Texture2D

func _ready() -> void:
	#var p = get_parent
	#p.lights_on.connect(fond_allume)
	texture = fond_eteint
	
func _fond_allume():
	texture = fond_allume
