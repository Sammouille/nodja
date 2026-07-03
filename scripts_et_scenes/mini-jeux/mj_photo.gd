extends Node2D

var nb_tentatives = 0
var pos_der_photo = Vector2(576,500)
@export var photo_retouchee : PackedScene
@export var sprite_tampon_valide : Texture
@export var stream_tampon : Node
@export var stream_gribouille : Node

@export var son_refuse : AudioStream
@export var son_valide : AudioStream

func _ready() -> void:
	stream_tampon.stream = son_refuse
	for i in get_children():
		if i.is_in_group("photo"):
			i.photo_clicked.connect(_on_photo_clicked)

func _on_photo_clicked():
	nb_tentatives += 1
	print("tentatives :" + str(nb_tentatives))
	stream_tampon.play()
	if nb_tentatives >= 5:
		print("photo retouchée")
		stream_gribouille.play()
		
func _instantiate_photo_retouchee():
		var nv_instance = photo_retouchee.instantiate()
		nv_instance.photo_retouchee_clicked.connect(_on_photo_retouchee_clicked)
		add_child(nv_instance)
		nv_instance.position = pos_der_photo

func _on_photo_retouchee_clicked():
	stream_tampon.stream = son_valide
	stream_tampon.play()
	print("BRAVO")
	var sprite_tampon = Sprite2D.new()
	sprite_tampon.texture = sprite_tampon_valide
	sprite_tampon.position = pos_der_photo
	add_child(sprite_tampon)
