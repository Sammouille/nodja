extends Control
class_name Page

var signet_hovered:= false

var ouverte:= false

var passee:= false

@export var contenu_visuel: Array[Node]

signal clic_signet(page: Page)

signal page_ouverte
signal page_fermee

@export var index:= 1

@export var signet: Control
@export var x_signet_gauche:= 100.0
@export var x_signet_droite := 100.0

func _ready() -> void:
	signet.mouse_entered.connect(_on_signet_mouse_entered)
	signet.mouse_exited.connect(_on_signet_mouse_exited)
	signet.position.x = x_signet_droite

func ouvrir_page():
	ouverte = true
	page_ouverte.emit()
	for i in contenu_visuel:
		i.show()

func fermer_page():
	ouverte = false
	page_fermee.emit()
	for i in contenu_visuel:
		i.hide()

func _on_signet_mouse_entered() -> void:
	signet_hovered = true

func _on_signet_mouse_exited() -> void:
	signet_hovered = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if signet_hovered:
				clic_signet.emit(self)
				#ouvrir_page()
