extends Sprite2D

@export var paint_color:= Color(1.0, 0.741, 0.0, 1.0)

@export var paint_size:= 3

var img: Image

var actif:= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
