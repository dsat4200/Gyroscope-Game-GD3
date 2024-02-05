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
	if(ray.is_colliding()):
		if(!collided):
			if(hover):
				#if nulll collision, and hover, unhover
				print("no longer hovering over " + hover.name)
				hover = null
				hover.hover(false) #HOVER IMPLEMENT PLEASE
			collided = ray.get_collider().get_parent()	
			hover = collided
			
			print("hovering over "+ hover.name)
		#if not null, check if not the same	
		elif(collided.name != ray.get_collider().get_parent().name):
				collided.hover(true);
				collided = ray.get_collider().get_parent()
				print(collided.name)

	elif(hover and collided):
		#if not colliding, and you were hovering, you aren't anymore
		collided = null
		print("no longer hovering over " + hover.name)
		hover = null
			
		
	
	
func rotate_camera(gyro_y, gyro_s, gyro_x, invert_y):
	rotate_y((gyro_y ) * -(gyro_s))
	camera.rotate_x((gyro_x * (gyro_s) * -invert_y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
