extends Node2D

var nb_tentatives = 0
@export var photo_retouchee : PackedScene

func _ready() -> void:
	for i in get_children():
		i.photo_clicked.connect(_on_photo_clicked)

func _on_photo_clicked():
	nb_tentatives += 1
	print("tentatives :" + str(nb_tentatives))
	if nb_tentatives >= 5:
		print("photo retouchée")
		var nv_instance = photo_retouchee.instantiate()
		nv_instance.photo_retouchee_clicked.connect(_on_photo_retouchee_clicked)
		add_child(nv_instance)
		nv_instance.position = Vector2(576, 500)

func _on_photo_retouchee_clicked():
	print("BRAVO")
