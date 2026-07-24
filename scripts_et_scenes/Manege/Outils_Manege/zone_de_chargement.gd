extends Area2D

signal load_zone()

func _on_body_entered(body: Node2D) -> void:
	load_zone.emit()
