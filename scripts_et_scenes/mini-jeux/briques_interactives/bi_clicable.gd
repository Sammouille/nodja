extends Area2D
class_name clicable

signal photo_clicked # signal envoyé à la scène MJPhoto quand la photo est cliquée

@export var tampon_refus : PackedScene

var hovered = false # stocke l'info la souris est elle sur cette photo ?
var used = false # stocke l'info cette photo a t elle déjà été cliquée ?

func _ready() -> void: # randomise légèrement la position et l'angle des photos
	rotation_degrees += randi_range(-20,20)
	position.x += randi_range(-20,20)
	position.y += randi_range(-20,20)

func _on_mouse_entered() -> void: # passe le booléen à vrai quand la souris rentre sur la photo
	hovered = true

func _on_mouse_exited() -> void: # passe le booléen à faux quand la souris ressort de la photo
	hovered = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("clic") and hovered: # réagit si la lic est appuyé et le curseur est sur la photo
			if !used: # chaque photo ne peut etre essayée qu'une fois dont elle réagit que si elle n'a pas encore été cliquée
				print("photo refusée")
				var nv_instance = tampon_refus.instantiate() # instancie le tampon de refus
				add_child(nv_instance) # ajoute l'instance du tampo à la scène
				photo_clicked.emit() # prévient MJPhoto qu'une nouvelle photo à été cliquée
				used = true
