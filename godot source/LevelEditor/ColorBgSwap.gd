tool
extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"`

onready var sphere = $Sphere
export var color : Color = Color.green setget _set_color, _get_color

func _set_color(input:Color)->void:
	color = input
	if not is_inside_tree():
		yield(self,"ready")
	$Sphere.get_surface_material(0).albedo_color = color
# Called when the node enters the scene tree for the first time.

func _get_color():
	return color


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

