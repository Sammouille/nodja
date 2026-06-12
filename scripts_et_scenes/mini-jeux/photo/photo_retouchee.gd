extends Area2D

var hovered = false
var used = false

signal photo_retouchee_clicked

func _ready() -> void:
	pass

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("clic") and hovered:
			print("clicgoch")
			if !used:
				print("photo refusée")
				photo_retouchee_clicked.emit()
				used = true
