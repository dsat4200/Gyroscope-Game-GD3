extends Control

var next_beat = 0.0
var beats

var spawned : PoolRealArray


# Declare member variables here. Examples:
# var a = 2
# var b = "text"y
func _ready() -> void:
	pass


			
func spawn_beat(position):
	if(position < get_child_count()):
		var new_beat: Node = get_child(position).scene.instance()
		get_child(position).add_child(new_beat)
		
		for i in beats.size():
			var check = beats[1+position+i]
			if("beat" in check[1] and !(check[0] in spawned)):
				#print()
				next_beat=beats[1+position+i][0]
				spawned.push_back(next_beat)
				break
		var distance_until_next_beat = next_beat - beats[position][0]
		#print("from beat " +String(beats[position][0]) +" to beat " + String(next_beat)+" is " + String(distance_until_next_beat))
		#last one is beat_delay. beat delay should be  the amount of time until the beat proper.
		#var time_until_next_beat = 
		var beat_data = [position+1, 1, distance_until_next_beat, next_beat]#[order_number, _speed, global_position, frame, bps? beatdelay?]
		new_beat.setup(beat_data)
		#print("next beat!: "+String(next_beat)+" current pos: "+String(position))


func _on_NTHE_beat(position):
	position-=1
	#print("NTHE beat!: "+String(position))
	if ("spawn" in beats[position][2]):
		print("spawn beat!: "+String(position)+": " + String(beats[position][0]))
		spawn_beat(position) # take note of offset
		#print(get_child(current_beat_index -2).get_children())
	if("beat" in beats[position][1]):
		print("beat!: "+String(position+1)+": " + String(beats[position][0]))
		spawned.remove(spawned.find(beats[position][0]))
	#print(String(spawned))
	pass # Replace with function body.


