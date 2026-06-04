extends Node2D
class_name clic

@export var click_cooldown := 0.5
var clickable = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("clic") and clickable:
			print("clicgoch")
			get_tree().create_timer(click_cooldown).timeout.connect(_set_clickable)
			clickable = false

func _set_clickable():
	clickable = true
