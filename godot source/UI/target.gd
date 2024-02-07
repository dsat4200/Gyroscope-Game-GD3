extends Spatial
export(Color) var to_color
export(Color) var from_color

var material

# Called when the node enters the scene tree for the first time.
	
func hover(b):
	if(b):
		set_color(to_color)
	else:
		set_color(from_color)


# Called when the node enters the scene tree for the first time.
func _ready():
	material = $target.get_active_material(0)

func set_color(c):
	material.albedo_color = c
