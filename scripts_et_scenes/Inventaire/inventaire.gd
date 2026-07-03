extends CanvasLayer


@export var key_in_inventory : bool = false
@export var scotch_in_inventory : bool = false

func _ready() -> void:
	if key_in_inventory:
		get_child(0).on_signal_to_add_object_from_str("cle_voiture_inventaire")
	
	if scotch_in_inventory:
		get_child(0).on_signal_to_add_object_from_str("rouleau_scotch_inventaire")
