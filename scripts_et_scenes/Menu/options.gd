extends CanvasLayer

signal back_option

func _on_back_pressed() -> void:
	self.visible = false
	emit_signal("back_option")
