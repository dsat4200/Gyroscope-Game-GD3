tool
extends Node
class_name beats

export var insert : float = 0 setget _set_insert, _get_insert

func _set_insert(x):
	find_order_to_place(x)
	
func _get_insert():
	return insert

onready var current_beat = get_child(0)
onready var beats 

export(NodePath) var conductor_path
onready var conductor = get_node(conductor_path)
onready var sec_per_beat = conductor.sec_per_beat

signal beats_updated(beats)

func get_beats() -> Array:
	var beat_positions : Array = []
	for N in get_children():
		beat_positions.append(N.pos)
	return beat_positions


func get_pure_beats() -> PoolRealArray:
	var beat_positions : PoolRealArray = []
	for N in get_children():
		beat_positions.append_array(N.pos)
	print("pure beats get: "+ String(beat_positions))
	return beat_positions


func _on_sequencer_add_beat(position):
	#take position. if between beats, add new beat.
	emit_signal("beats_updated", get_pure_beats())

func find_order_to_place(pos) -> int:#returns the index the new beat object should be placed in
	var arrayOfArrays = get_beats()
	#print(String(arrayOfArrays))
	 # Iterate through the array of arrays
	for i in range(arrayOfArrays.size()):
		var array = arrayOfArrays[i]
		var nextArray = []
		#print(String(i)+" "+String(arrayOfArrays.size()))
		var size = arrayOfArrays.size()
		if(i < size-1):
			nextArray = arrayOfArrays[i + 1]
		else:
			nextArray = []

		#print("array is: "+String(array))

		# Check if the position is between the last element of the current array
		# and the first element of the next array
		#print(String(array[-1])+" " + String(pos)+" " + String(nextArray[0]))
		
		#check end
		if array.size() > 0 and nextArray.size() == 0 and pos > array[array.size()-1]:
			arrayOfArrays.insert(i+1, [pos])
			print("array"+String(arrayOfArrays))
			return i+1
		#if between, insert
		if array.size() > 0 and nextArray.size() > 0 and array[-1] < pos and pos < nextArray[0]:
			arrayOfArrays.insert(i + 1, [pos])
			print("new array at "+String(arrayOfArrays))
			return i+1

		#if inside, insert too
		#print("Checking: "+String(array) +" with "+ String(pos))
		for j in range(array.size() - 1):
			if array[j] < pos and pos < array[j + 1]:
				var away = arrayOfArrays[i]
				away.insert(j+1, pos)
				arrayOfArrays[i] = away
				print("array"+String(arrayOfArrays))
				return i
		
		#if not last or in between, add to start
		if array.size() > 0 and pos < array[0]:
			arrayOfArrays.insert(0, [pos])
			print("array"+String(arrayOfArrays))
			return 0
	print("array"+String(arrayOfArrays))
	return -1

func update_names():
	for N in get_children():
		N.name = "gloop"
	for N in get_children():
		N.name = "b_"+String(N.order)
