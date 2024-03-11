extends Control

var current_beat_index = 0
var next_beat_index = 1
var beats
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func spawn_beat(index):
	if(index < get_child_count()):
		var new_beat: Node = get_child(index).scene.instance()
		get_child(index).add_child(new_beat)
		var beat_data = [index, 1]#[order_number, _speed, global_position, frame, bps? beatdelay?]
		new_beat.setup(beat_data)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NTHE_beat(position):
	print("NTHE beat!: "+String(position))
	spawn_beat(current_beat_index)
	next_beat_index+=1
	current_beat_index+=1
	pass # Replace with function body.
