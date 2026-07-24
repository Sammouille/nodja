extends Sprite2D

@export var tampon1 : Texture
@export var tampon2 : Texture
@export var tampon3 : Texture

func _ready() -> void: # randomise la texture utilisée pour le tampon
	var rng = randi_range(1,3) # tire au hasard un chiffre de 1 à 3
	match rng: # assigne une texture de tampon différente selon la valeur de rng
		1:
			texture = tampon1
		2:
			texture = tampon2
		3:
			texture = tampon3
	# randomise la position et l'angle du tampon
	position.x += randi_range(-5,5)
	position.y += randi_range(-5,5)
	rotation_degrees += randi_range(-60,60)
