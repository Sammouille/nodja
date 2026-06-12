extends Sprite2D

@export var tampon1 : Texture
@export var tampon2 : Texture
@export var tampon3 : Texture

func _ready() -> void:
	var rng = randi_range(1,3)
	match rng:
		1:
			texture = tampon1
		2:
			texture = tampon2
		3:
			texture = tampon3
	position.x += randi_range(-5,5)
	position.y += randi_range(-5,5)
	rotation_degrees += randi_range(-60,60)
