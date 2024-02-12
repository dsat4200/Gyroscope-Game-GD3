extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = $camera
onready var ray = $camera/ray

var collided
var hover

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if ray.is_colliding():
		var new_hover = ray.get_collider().get_parent()
		if not collided or collided.name != new_hover.name:
			if hover:
				hover.hover(false)
				#print("no longer hovering over " + hover.name)
			hover = new_hover
			collided = hover
			#print("hovering over " + hover.name)
			hover.hover(true)  # Added line to enable hover
	elif hover:
		hover.hover(false)
		#print("no longer hovering over " + hover.name)
		hover = null
		collided = null


			
		
	
	
func rotate_camera(gyro_y, gyro_s, gyro_x, invert_y):
	rotate_y((gyro_y ) * -(gyro_s))
	camera.rotate_x((gyro_x * (gyro_s) * -invert_y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
