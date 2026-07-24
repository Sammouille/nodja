extends Sprite2D

## Couleur de dessin lors de la premiere ouverture de la page
@export var paint_color:= Color(1.0, 0.741, 0.0, 1.0)

## Taille du pinceau à définir dans l'inspecteur de la node
@export var paint_size:= 3

# Référence à l'image qui contient les dessins.
var img: Image

# Boolean changé dans le script la node parent lorsque la page s'ouvre.
var actif:= false

# Boolean pour ne pas donner plusieurs fois le crayon
var one_item:= true

# Fonction appelée au démarrage de l'execution.
func _ready() -> void:
	# On crée l'image de base qui est un carré transparent
	img = Image.create_empty(1920, 1080, false, Image.FORMAT_RGBA8)
	img.fill(Color.TRANSPARENT)
	texture = ImageTexture.create_from_image(img)

func peindre(pos: Vector2):
	if actif:
		img.fill_rect(Rect2i(pos, Vector2(1,1)).grow(paint_size), paint_color)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var lpos = to_local(event.position)
		var impos = lpos-offset + get_rect().size/2.0
		
		peindre(impos)
		texture.update(img)
		
		if get_parent().index >= 2 and one_item:
			one_item = false
			get_tree().get_first_node_in_group("Inventaire").get_child(0).on_signal_to_add_object_from_str("crayon_inventaire")
		
	elif event is InputEventMouseMotion:
		if event.button_mask ==  MOUSE_BUTTON_LEFT:
			var lpos = to_local(event.position)
			var impos = lpos-offset + get_rect().size/2.0
			
			if event.relative.length_squared() > 0:
				var num:= ceili(event.relative.length())
				var target_pos = impos - (event.relative)
				for i in num:
					impos = impos.move_toward(target_pos, 1.0)
					peindre(impos)
			
			texture.update(img)
