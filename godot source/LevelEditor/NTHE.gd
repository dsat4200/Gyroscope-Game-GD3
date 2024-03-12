extends Spatial
onready var anim_player = $AnimationPlayer
export(NodePath) var beats_path
onready var beats = get_node(beats_path).get_beat_cues()
signal start
signal beat(position)
onready var hitbeats = $Gyro/HitBeats

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hitbeats.beats = beats
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	


func _on_Conductor_beat(position):
	emit_signal("beat", position)
	resync_beat(position)

func resync_beat(position):
	#print("resyncing to: "+String(beats[position][0]))
	anim_player.play("NTHE")
	anim_player.seek(beats[position][0])


func _on_Conductor_start():
	emit_signal("start")
	pass
	#print("Conductor Start!")
