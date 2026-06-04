extends Area2D
class_name clicable

signal photo_clicked

var hovered = false
var used = false

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
				photo_clicked.emit()
				used = true
