extends CanvasLayer

#Variable modifiable depuis l'éditeur permettant de modifier les paramètres initiaux de l'inventaire. Utile pour le debug et des tests.
@export var key_in_inventory : bool = false
@export var scotch_in_inventory : bool = false

func _ready() -> void:
	#Si la variable est <true> alors met directement la clé dans l'inventaire.
	if key_in_inventory:
		get_child(0).on_signal_to_add_object_from_str("cle_voiture_inventaire")
	
	#Si la variable est <true> alors met directement le scotch dans l'inventaire.
	if scotch_in_inventory:
		get_child(0).on_signal_to_add_object_from_str("rouleau_scotch_inventaire")
