extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camera

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func rotate_camera(gyro_y, gyro_s, gyro_x, invert_y):
	rotate_y((gyro_y ) * -(gyro_s))
	camera.rotate_x((gyro_x * (gyro_s) * -invert_y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
