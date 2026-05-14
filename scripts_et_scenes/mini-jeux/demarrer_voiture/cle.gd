extends TextureRect

@onready var png_cle = preload("res://ressource/mj_demarrer_voiture/cle_voiture.png")
@onready var png_cle_tournee = preload("res://ressource/mj_demarrer_voiture/cle_voiture_tournee.png")

@onready var TimerCle = $TimerCle

@export var PosPourTourner : Control
@export var PosMax : Control

var is_mouse_in : bool = false

var mouse_drag_pos : Vector2 = Vector2(0.0, 0.0)
var original_pos : Vector2 = Vector2(0.0, 0.0)


func _ready() -> void:
	original_pos = global_position


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("clique_droit"):
		texture = png_cle_tournee
		TimerCle.start()
	
	if Input.is_action_just_pressed("clique_gauche"):
		if is_mouse_in:
			mouse_drag_pos = get_viewport().get_mouse_position()
			#print(mouse_drag_pos)
	
	if is_mouse_in and Input.is_action_pressed("clique_gauche") and event is InputEventMouseMotion:
		var temp_current_mouse_pos = get_viewport().get_mouse_position()
		var temp_x = ( abs(mouse_drag_pos.x) - abs(temp_current_mouse_pos.x) ) * (  abs(temp_current_mouse_pos.x) / temp_current_mouse_pos.x )
		mouse_drag_pos = temp_current_mouse_pos
		
		if position.x + temp_x *-1 > PosPourTourner.global_position.x and position.x + temp_x *-1 < PosMax.global_position.x:
			position.x += temp_x *-1
		

func _on_mouse_entered() -> void:
	#print("mouse in")
	is_mouse_in = true


func _on_mouse_exited() -> void:
	#print("mouse out")
	is_mouse_in = false


func _on_timer_cle_timeout() -> void:
	texture = png_cle
	global_position = original_pos
