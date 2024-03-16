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
	$AudioStreamPlayer.stop()
	#AnimationPlayer
	$AnimationPlayer.get_animation("NTHE").remove_track(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	


func _on_Conductor_beat(position):
	anim_player.play("NTHE")
	anim_player.seek(beats[position][0])
	emit_signal("beat", position)
	


func _on_Conductor_start():
	emit_signal("start")
	pass
	#print("Conductor Start!")

#fix me please
func _on_LevelEditor_please_reload():
	get_tree().paused = false
	$graphic_elements.set_translation(Vector3.ZERO)
	$graphic_elements/circe/AnimationPlayer.seek(0)
	$graphic_elements/circe/AnimationPlayer.play()
	get_tree().reload_current_scene()
