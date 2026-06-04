extends Control
class_name Page

var signet_hovered:= false

var ouverte:= false

var passee:= false

@export var contenu_visuel: Array[Control]

signal clic_signet(page)

@export var index:= 1

@export var signet: Control

func ouvrir_page():
	ouverte = true
	for i in contenu_visuel:
		i.show()

func _on_signet_mouse_entered() -> void:
	print("on")
	signet_hovered = true

func _on_signet_mouse_exited() -> void:
	print("off")
	signet_hovered = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if signet_hovered:
				clic_signet.emit(self)
				ouvrir_page()
