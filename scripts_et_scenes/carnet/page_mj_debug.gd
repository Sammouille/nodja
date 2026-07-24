extends Page
# Script pour une page qui rendrait un signet visible


@export var signet_unlock: Control

func _on_button_pressed() -> void:
	$PageDroite/Button.disabled
	signet_unlock.show()
	
