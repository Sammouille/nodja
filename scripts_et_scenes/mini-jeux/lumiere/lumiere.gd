extends Area2D

signal light_clicked

@export var lampe_eteinte : Texture2D
@export var lampe_allumee : Texture2D

var hovered = false
var used = false

func _ready() -> void:
	$Sprite2D.texture = lampe_eteinte
	rotation_degrees += randi_range(-50,50)
	position.x += randi_range(-50,50)
	position.y += randi_range(-50,50)

func _on_mouse_entered() -> void:
	hovered = true
	#print("on")

func _on_mouse_exited() -> void:
	hovered = false
	#print("off")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("clic") and hovered:
			if !used:
				print("lumière allumée")
				$Sprite2D.texture = lampe_allumee
				light_clicked.emit()
				used = true

#func _fond_allume():
	#print("disparu")
	#visible = false
