extends Area2D
class_name clicable

signal photo_clicked

@export var tampon_refus : PackedScene

var hovered = false
var used = false

func _ready() -> void:
	rotation_degrees += randi_range(-20,20)
	position.x += randi_range(-20,20)
	position.y += randi_range(-20,20)

func _on_mouse_entered() -> void:
	hovered = true
	#print("on")

func _on_mouse_exited() -> void:
	hovered = false
	#print("off")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("clic") and hovered:
			#print("clicgoch")
			if !used:
				print("photo refusée")
				var nv_instance = tampon_refus.instantiate()
				add_child(nv_instance)
				photo_clicked.emit()
				used = true
