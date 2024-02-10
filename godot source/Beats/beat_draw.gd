extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func draw_beatmarker(beatposition, songpos):
	#print("beat! pos: "+String(beatposition)+", time: "+String(songpos))
	if (beatposition > 0):
		var next_beat = $b_0.duplicate()
		add_child(next_beat)
		next_beat.rect_position.x = songpos
		next_beat.name = "b_"+String(beatposition)
		next_beat.get_child(0).text = String(beatposition)
		next_beat.visible= true
		print("beat! "+String(next_beat.name)+", pos: "+String(next_beat.rect_position.x))

func _on_Conductor_beat(position):
	pass # Replace with function body.
