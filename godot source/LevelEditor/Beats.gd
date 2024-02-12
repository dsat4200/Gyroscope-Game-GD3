tool
extends Node
class_name beats

export var order : int = 0 setget _set_order, _get_order

onready var current_beat = get_child(0)
onready var beats 

export(NodePath) var conductor_path
onready var conductor = get_node(conductor_path)
onready var sec_per_beat = conductor.sec_per_beat

signal beats_updated(beats)




func _ready():
	print("beat interval:"+String(sec_per_beat))

func get_pure_beats() -> PoolRealArray:
	var beat_positions : PoolRealArray = []
	for N in get_children():
		beat_positions.append_array(N.pos)
	print("pure beats get: "+ String(beat_positions))
	return beat_positions


func _on_sequencer_add_beat(position):
	#take position. if between beats, add new beat.
	emit_signal("beats_updated", get_pure_beats())

func find_order_to_place(pos):
	var arrayOfArrays = get_beats()
	 # Iterate through the array of arrays
	for i in range(arrayOfArrays.size() - 1):
		var array = arrayOfArrays[i]
		var nextArray = arrayOfArrays[i + 1]

		# Check if the position is between the last element of the current array
		# and the first element of the next array
		if array.size() > 0 and nextArray.size() > 0 and array[-1] < pos < nextArray[0]:
			arrayOfArrays.insert(i + 1, [pos])
			print("new array at "+String(arrayOfArrays))
			return

		# Check if the position fits between two elements in the same array
		for j in range(array.size() - 1):
			if array[j] < pos < array[j + 1]:
				array.insert(j + 1, pos)
				print("insert to array "+ String(arrayOfArrays))
				return

	# If the position doesn't fit between any existing elements, add it to the last array
	arrayOfArrays[-1].append(pos)

func update_names():
	for N in get_children():
		N.name = "gloop"
	for N in get_children():
		N.name = "b_"+String(N.order)
