extends Label
var mode = "PLAY"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_mode("")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_mode(val):
	if(val==""):
		val = "PLAY"
	else:	
		text = "Mode: "+val

func _on_HitBeats_edit_mode(val):
	if (val):
		update_mode("EDIT")
	else:
		update_mode("")
