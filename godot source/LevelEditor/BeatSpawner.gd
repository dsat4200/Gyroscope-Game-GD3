extends Control

var current_beat_index = 0
var next_beat = 0.0
var beats


# Declare member variables here. Examples:
# var a = 2
# var b = "text"y
func _ready() -> void:
	pass


			
func spawn_beat(index, position):
	if(index < get_child_count()):
		var new_beat: Node = get_child(index).scene.instance()
		get_child(index).add_child(new_beat)
		
		for i in beats.size():
			if("beat" in beats[1+position+i][1]):
				next_beat=beats[1+position+i][0]
				break

		var distance_until_next_beat = next_beat - beats[position][0]
		print("from beat " +String(beats[position][0]) +" to beat " + String(next_beat)+" is " + String(distance_until_next_beat))
		#last one is beat_delay. beat delay should be  the amount of time until the beat proper.
		#var time_until_next_beat = 
		var beat_data = [index+1, 1, distance_until_next_beat, next_beat]#[order_number, _speed, global_position, frame, bps? beatdelay?]
		new_beat.setup(beat_data)


func _on_NTHE_beat(position):
	#print("NTHE beat!: "+String(position))
	if ("spawn" in beats[position][2]):
		#print("next is beat!: "+String(position)+": " + String(beats[position][0]))
		spawn_beat(current_beat_index, position) # take note of offset
		current_beat_index+=1
		#print(get_child(current_beat_index -2).get_children())
	if("beat" in beats[position][1]):
		#print("beat!: "+String(position)+": " + String(beats[position][0]))
		pass
	pass # Replace with function body.


