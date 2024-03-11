extends Spatial
onready var anim_player = $AnimationPlayer
export(NodePath) var beats_path
onready var beat = get_node(beats_path).get_pure_beats()
signal start

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	


func _on_Conductor_beat(position):
	resync_beat(position)

func resync_beat(position):
	print("resyncing to: "+String(beat[position]))
	anim_player.play("NTHE")
	anim_player.seek(beat[position])
