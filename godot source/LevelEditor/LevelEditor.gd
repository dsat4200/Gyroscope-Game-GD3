extends Spatial

onready var conductor = $Conductor

export(NodePath) var HitBeatsPath
onready var HitBeats = get_node(HitBeatsPath)

signal please_reload
export var starting_beat:=0

func _init():
	OS.set_current_screen(1)
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("reload", self, "reload")
	#print("1")
	conductor.starting_beat = starting_beat
	HitBeats.starting_beat = starting_beat
	conductor.play_with_beat_offset(0)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func reload():
	print("reload please!")
	emit_signal("please_reload")

func _on_Conductor_start():
	pass # Replace with function body.
