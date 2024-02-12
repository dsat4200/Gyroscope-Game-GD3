tool
extends Node
class_name beats


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

func get_beats() -> Array:
	var beat_positions : Array = []
	for N in get_children():
		beat_positions.append(N.pos)
	return beat_positions

func _on_sequencer_add_beat(position):
	#take position. if between beats, add new beat.
	emit_signal("beats_updated", get_pure_beats())

func find_order_to_place(pos):
	pass

func update_names():
	for N in get_children():
		N.name = "gloop"
	for N in get_children():
		N.name = "b_"+String(N.order)
