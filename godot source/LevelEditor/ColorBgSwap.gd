extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sphere = $Sphere
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func switch_color(input_color: Color):
	# Process the color here (Example: Invert the color)
	sphere.get_surface_material(0).albedo_color = input_color
