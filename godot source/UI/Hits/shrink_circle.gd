extends MeshInstance2D

# Properties
var shrink_duration = 2.0 # Duration of the shrinking animation in seconds
var target_scale = Vector2(1, 1) # Target scale to shrink to
var time_elapsed = 0.0 # Time elapsed since the shrinking started
onready var original_scale = scale
func _init() -> void:
	set_process(false)


func _process(delta):
	# Increment time elapsed
	time_elapsed += delta
	#print(time_elapsed)
	# Calculate the current scale based on time elapsed
	var progress = min(1.0, time_elapsed / shrink_duration)
	#print("progress: "+String(progress))
	#print("shrink duration"+String(shrink_duration))
	var new_scale = original_scale.linear_interpolate(target_scale, progress)
	scale = new_scale
	
func setup(duration):
	shrink_duration = duration
	time_elapsed = 0.0 # Reset time elapsed
	#print("duration set: "+String(duration))
	set_process(true)


func _on_Timer_timeout():
	scale = Vector2(1, 1) # Ensure scale is exactly (1,1)

