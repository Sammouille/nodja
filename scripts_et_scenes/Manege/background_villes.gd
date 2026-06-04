extends Node2D

@export var garage: Node2D
@export var route_asphalt : TileMapLayer

@export var height_route_asphalt := 580.0
@onready var jantes := garage.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	route_asphalt.position.y = height_route_asphalt
	ManagerResolution.adapt_res_scale.connect(adapt_display.bind())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if jantes.position.y >= route_asphalt.position.y:
		##parallax.scroll_offset.y = jantes.position.y - 580.0
		#var p_sc = jantes.hauteur_voiture.get_collision_point().y / height_route_asphalt
		#parallax.scale = Vector2(p_sc,p_sc)

func adapt_display(scale_adapte):
	self.scale = Vector2(scale_adapte,scale_adapte)
