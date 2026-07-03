extends TextureRect

@onready var png_cle = preload("res://assets/mj_demarrer_voiture/cle_voiture.png")
@onready var png_cle_tournee = preload("res://assets/mj_demarrer_voiture/cle_voiture_tournee.png")

#Timer qui permet de réinitialiser la position de la clé
@onready var TimerCle = $TimerCle

#Limites de position du drag de la clé. "PosPourTourner" étant aussi la position pour gagner le mini jeu.
@export var PosPourTourner : Control
@export var PosMax : Control

#Variables qui permet de savoir facilement où est la souris.
var is_mouse_in : bool = false
var is_on_good_pos : bool = false

#Variable qui vérifie la victoire du mini jeu.
var has_win : bool = false

#Position actuelle de la souris pendant le drag.
var mouse_drag_pos : Vector2 = Vector2(0.0, 0.0)
#Position de début de la clé.
var original_pos : Vector2 = Vector2(0.0, 0.0)


func _ready() -> void:
	#Sauvegarde de la position de début de la clé.
	original_pos = global_position


func _input(event: InputEvent) -> void:
	#Le clique_droit permet de tourner la clé. Si elle est bien positionnée et que le scotch est présent dans la scène, le mini jeu est gagné. Sinon, le timer pour réinitialisé la clé est lancé.
	if Input.is_action_just_pressed("clique_droit"):
		texture = png_cle_tournee
		if is_on_good_pos and get_parent().has_scotch:
			print("voiture demarre")
			has_win = true
		else:
			TimerCle.start()
	
	#Vérifie l'input de drag.
	if Input.is_action_just_pressed("clique_gauche"):
		#Est-ce que la souris est sur la clé.
		if is_mouse_in:
			#Sauvegarde alors la position de la souris ce qui évite un décalage de position pour la suite.
			mouse_drag_pos = get_viewport().get_mouse_position()
			#print(mouse_drag_pos)
	
	#Si la souris drag la clé et qu'elle bouge, alors la clé bouge aussi.
	if !has_win and is_mouse_in and Input.is_action_pressed("clique_gauche") and event is InputEventMouseMotion:
		#Récup de la position de la souris sur l'écran.
		var temp_current_mouse_pos = get_viewport().get_mouse_position()
		#On calcule la différence de position entre celle actuelle et la dernière enregistrée.
		var temp_x = ( abs(mouse_drag_pos.x) - abs(temp_current_mouse_pos.x) ) * (  abs(temp_current_mouse_pos.x) / temp_current_mouse_pos.x )
		#On enregistre l'actuelle.
		mouse_drag_pos = temp_current_mouse_pos
		
		#Si la clé n'a pas atteint les limites de positionnement, alors elle peut encore bouger.
		if position.x + temp_x *-1 > PosPourTourner.position.x and position.x + temp_x *-1 < PosMax.position.x:
			position.x += temp_x *-1
			#Si la clé est sur la bonne position ou pas, on l'enregistre. Marge de 20 unités.
			if position.x <= PosPourTourner.position.x + 20:
				if !is_on_good_pos:
					is_on_good_pos = true
			else:
				if is_on_good_pos:
					is_on_good_pos = false


#Est appelé quand la souris survole la clé.
func _on_mouse_entered() -> void:
	#print("mouse in")
	is_mouse_in = true


#Est appelé quand la souris ne survole plus la clé.
func _on_mouse_exited() -> void:
	#print("mouse out")
	is_mouse_in = false


#Est appelé à la fin du timer de réinitialisation.
func _on_timer_cle_timeout() -> void:
	texture = png_cle
	global_position = original_pos
	is_on_good_pos = false
