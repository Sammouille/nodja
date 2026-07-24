extends Area2D

signal light_clicked

@export var lampe_eteinte : Texture2D
@export var lampe_allumee : Texture2D

var hovered = false
var used = false

func _ready() -> void:
	$Sprite2D.texture = lampe_eteinte # prend la texture de lampe éteinte
	# randomise l'angle et la position de la lumière
	rotation_degrees += randi_range(-50,50)
	position.x += randi_range(-50,50)
	position.y += randi_range(-50,50)

func _on_mouse_entered() -> void: # passe la variable à vrai quand la souris entre sur la lumière
	hovered = true

func _on_mouse_exited() -> void: # passe la variable à faux quand la souris sort de la lumière
	hovered = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("clic") and hovered: # réagit si le clic est appuyé et la osuris est sur la lumière
			if !used: # ne réagit que si la lumière n'a pas encore été allumée
				$Sprite2D.texture = lampe_allumee # prend la texture de lampe allumée
				light_clicked.emit() # prévient MJLumière qu'une nouvelle lumière à été allumée
				used = true
