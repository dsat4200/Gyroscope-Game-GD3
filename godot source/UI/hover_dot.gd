extends Spatial
export(Color) var to_color
export(Color) var from_color

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	from_color = $target.color
	
func hover(b):
	if(b):
		$target.set_color(to_color)
	else:
		$target.set_color(from_color)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
