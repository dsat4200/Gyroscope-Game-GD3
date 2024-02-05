extends Spatial
export(Color) var color

var material

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	material = $target.get_active_material(0)
	#color = mesh_instance.material.albedo_color

func set_color(c):
	material.albedo_color = c

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
