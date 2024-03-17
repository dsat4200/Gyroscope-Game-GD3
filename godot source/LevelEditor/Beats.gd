extends Node

export(Resource) var csv_path
onready var beats 
var data : PoolRealArray = []

signal beats_updated(beats)

func _ready():
	var markers = csv_path.records
	for N in markers:
		#if N.get_index() != 0:
		data.append(N[0])


func get_pure_beats() -> PoolRealArray:
	return data

func get_beat_cues() -> Array:
	var cues = csv_path.records
	#print(cues)
	return cues
