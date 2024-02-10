extends ColorRect
export(Color) var to_color
export(Color) var from_color

var beat = false

func _ready():
	color = from_color

func _process(delta):
	pass
#	if(beat):
#		color = to_color
#		beat = false
#	else:
#		color = from_color

	
#	if(color == from_color): 
#		color = to_color
#	else: color = from_color



func _on_Conductor_beat(position):
	#beat = true
	$anim_player.play("beat")
	$BeatLabel.text = "BeatPosition: "+ String(position)
