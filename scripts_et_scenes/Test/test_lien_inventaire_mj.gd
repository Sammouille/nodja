extends CanvasLayer


@onready var MjAffiche = $Carnet/Control/MjAffiche
@onready var MjDemarrerVoiture = $Carnet/Control/MjDemarrerVoiture


signal donne_cle_voiture_inventaire

func _ready() -> void:
	for i in get_tree().current_scene.get_children():
		if i.is_in_group("Inventaire"):
			connect("donne_cle_voiture_inventaire", i.get_child(0).on_signal_to_add_object_from_str)
	
	emit_signal("donne_cle_voiture_inventaire", "cle_voiture_inventaire")


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_1"):
		#emit_signal("donne_cle_voiture_inventaire", "cle_voiture_inventaire")
		MjAffiche.visible = true
		MjDemarrerVoiture.visible = false
	
	if Input.is_action_just_pressed("debug_2"):
		#emit_signal("donne_cle_voiture_inventaire", "cle_voiture_inventaire")
		MjAffiche.visible = false
		MjDemarrerVoiture.visible = true
	
	pass
