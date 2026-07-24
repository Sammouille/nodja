extends Node2D

var nb_tentatives = 0
var pos_der_photo = Vector2(576,500)

#definition des elements
@export var photo_retouchee : PackedScene
@export var sprite_tampon_valide : Texture
@export var stream_tampon : Node
@export var stream_gribouille : Node

# assignation des feedbacks audio
@export var son_refuse : AudioStream
@export var son_valide : AudioStream

func _ready() -> void:
	stream_tampon.stream = son_refuse
	for i in get_children(): # se connecte aux signaux de toutes les photos de la scène
		if i.is_in_group("photo"):
			i.photo_clicked.connect(_on_photo_clicked)

func _on_photo_clicked(): # compte le nombre de photos essayées et joue les feedbacks audio
	nb_tentatives += 1
	print("tentatives :" + str(nb_tentatives))
	stream_tampon.play()
	if nb_tentatives >= 5: # si toutes les photos ont été essayées, on lance l'apparition de la photo retouchée
		print("photo retouchée")
		stream_gribouille.play() # la signal de fin de l'audio appelle la fonction d'instanciation de la photo retouchée
		
func _instantiate_photo_retouchee(): # fait apparaitre la photo retouchée (branchée au signal de fin de l'audio de gribouille)
		var nv_instance = photo_retouchee.instantiate()
		nv_instance.photo_retouchee_clicked.connect(_on_photo_retouchee_clicked)
		add_child(nv_instance)
		nv_instance.position = pos_der_photo

func _on_photo_retouchee_clicked(): # joue les feedbacks de validation de la photo retouchée
	stream_tampon.stream = son_valide
	stream_tampon.play()
	var sprite_tampon = Sprite2D.new() # instancie le tampon validé
	sprite_tampon.texture = sprite_tampon_valide
	sprite_tampon.position = pos_der_photo
	add_child(sprite_tampon) # ajoute le tampon validé à la scène
	
	# Quand le bruit de validation est fini on ajoute le tampon à l'inventaire
	await stream_tampon.finished
	get_tree().get_first_node_in_group("Inventaire").get_child(0).on_signal_to_add_object_from_str("tampon_inventaire")
