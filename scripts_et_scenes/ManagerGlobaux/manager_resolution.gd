extends Node

var res_horizontal = [1152,1920]
var res_vertical = [648,1080]

## Finalement peute tre que ça sert à rien de scale les éléments
var res_scale = [1.0,1.0]

@export var control_resolution_list : Control
signal adapt_res_scale(resolution_scaling)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_manager_resolution"):
		control_resolution_list.visible = !control_resolution_list.visible
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_res_list_item_selected(index: int) -> void:
	print("bah alors camarade?   ", index)
	DisplayServer.window_set_size(Vector2i(res_horizontal[index],res_vertical[index]))
	adapt_res_scale.emit(res_scale[index])
	
