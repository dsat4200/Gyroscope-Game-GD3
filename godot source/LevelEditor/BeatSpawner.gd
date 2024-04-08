extends Control

var next_beat = 0.0
var beats

var spawned : PoolRealArray
var starting_beat = 0
onready var cursor = get_parent().find_node("Cursor")
var current_beat = 0

var edit_mode = false
signal edit_mode(val)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"y
func _ready() -> void:
	pass
func _input(event):
	if event.is_action_pressed("middle_click"):
		edit_mode = !edit_mode
		emit_signal("edit_mode", edit_mode)

			
func spawn_beat(spawn,position):
	print(current_beat)
	if(current_beat < get_child_count()):
		var new_beat:Node
		if(spawn):
			var corresponding_beat = get_child(current_beat)
			if(edit_mode == true):
				corresponding_beat.global_position = cursor.rect_global_position
			new_beat = corresponding_beat.scene.instance()
			get_child(current_beat).add_child(new_beat)
			
		for i in beats.size():
			var check = beats[1+position+i]
			if("beat" in check[1] and !(check[0] in spawned)):
				#print()
				next_beat=beats[1+position+i][0]
				spawned.push_back(next_beat)
				break
		
		var distance_until_next_beat = next_beat - beats[position][0]
		var beat_data = [current_beat+1, 1, distance_until_next_beat, next_beat]#[order_number, _speed, global_position, frame, bps? beatdelay?]
		
		if(spawn):
			new_beat.setup(beat_data)
			#print("spawned!")
	current_beat+=1


func _on_NTHE_beat(position):
	#print(current_beat)
	position-=1
	#print("NTHE beat!: "+String(position+1))
	if ("spawn" in beats[position][2]):
			#print("spawn beat!: "+String(position+1)+": " + String(beats[position][0]))
		spawn_beat(true,position) # take note of offset
		#print(get_child(current_beat_index -2).get_children())
	if("beat" in beats[position][1]):
		print("beat!: "+String(position+1)+": " + String(beats[position][0])+" "+String(beats[position][3]))
		if(spawned.size()>0):
			spawned.remove(spawned.find(beats[position][0]))

func seek_to_beat(beat):
	#print(current_beat)
	for i in beat-1:
		var position = i
		#print(position)
		if ("spawn" in beats[position][2]):
			#print("spawn beat!: "+String(position+1)+": " + String(beats[position][0]))
			if (i == beat-1):
				spawn_beat(true,position) # take note of offset
			else:
				spawn_beat(false,position)
		#print(get_child(current_beat_index -2).get_children())
		if("beat" in beats[position][1]):
			#print("beat!: "+String(position+1)+": " + String(beats[position][0]))
			spawned.remove(spawned.find(beats[position][0]))
		#print(spawned)
	#print("seeked! current state:")
	#print("beat to seek to: "+String(beat))
	#print("spawned list: "+String(spawned))


func _on_Gyro_start():
	seek_to_beat(starting_beat)
