extends Control
class_name Page

var signet_hovered:= false

var ouverte:= false

var passee:= false

@export var contenu_visuel: Array[Node]

signal clic_signet(page: Page)

@export var index:= 1

@export var signet: Control
@export var x_signet:= 100.0

func _ready() -> void:
	signet.mouse_entered.connect(_on_signet_mouse_entered)
	signet.mouse_exited.connect(_on_signet_mouse_exited)
	if x_signet < -100.0:
		signet.position.x = abs(x_signet) - 100
	else:
		signet.position.x = x_signet

func ouvrir_page():
	ouverte = true
	for i in contenu_visuel:
		i.show()

func fermer_page():
	ouverte = false
	for i in contenu_visuel:
		i.hide()

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
				#ouvrir_page()
