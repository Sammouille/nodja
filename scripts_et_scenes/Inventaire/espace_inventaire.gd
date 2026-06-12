extends Control


@onready var element_test = preload("res://scripts_et_scenes/Inventaire/element_test.tscn")


@onready var tab_elements = []


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_1"):
		add_object(element_test)


func add_object(object):
	#print("en train ajouter element")
	var tmp = object.instantiate()
	self.add_child(tmp)
	tab_elements.append(object)
	#print("fini ajouter " + tmp.name)
