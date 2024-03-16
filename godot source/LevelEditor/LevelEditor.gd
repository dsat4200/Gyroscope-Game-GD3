extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(AudioStream) var stream
onready var conductor = $Conductor
onready var sequencer = $sequencer
signal please_reload

func _init():
	OS.set_current_screen(1)
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("reload", self, "reload")
	#print("1")
	conductor.stream = stream
	sequencer.import_clip(stream)
	conductor.play_with_beat_offset(0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func reload():
	print("reload please!")
	emit_signal("please_reload")

func _on_Conductor_start():
	pass # Replace with function body.
