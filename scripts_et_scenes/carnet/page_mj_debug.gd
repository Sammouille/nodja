extends Page

@export var signet_unlock: Control

func _on_button_pressed() -> void:
	$PageDroite/Button.disabled
	signet_unlock.show()
	
