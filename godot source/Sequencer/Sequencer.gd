extends Control

# project settings > audio > enable audio input
export var stream : AudioStreamSample

export(NodePath) var conductor_path
onready var conductor = get_node(conductor_path)
export(NodePath) var remote_transform_path


signal beat(position)
signal add_beat(position)

	#clip = conductor.stream


func play():
	$ClipScroller.play()

func import_clip(s:AudioStreamSample):
	$ClipScroller.conductor = conductor
	if s == null: print("WARNING! NO STREAM")
	else:
		var d = s.data
		d.append_array(s.data)
		s.data = d
		$ClipScroller.sample = s
		$ClipScroller/Prompter.get_clip().sample = $ClipScroller.sample

func _process(_dt):
	if Input.is_action_just_released("ui_select"):
		if $ClipScroller.playing:
			$ClipScroller.stop()
			#print("head stopped at:", $ClipScroller.head)
		else: $ClipScroller.play()

#func _input(event):
#	if event is InputEventKey and event.pressed:
#		if event.scancode == KEY_UP:
#			$Prompter.cursor -= 1
#			$ClipScroller.sample = $Prompter.sample
#		if event.scancode == KEY_DOWN:
#			$Prompter.cursor += 1
#			$ClipScroller.sample = $Prompter.sample
#		if event.scancode == KEY_HOME:
#			$ClipScroller.head = 0.0
	
	

func _on_Conductor_beat(beatposition):
	emit_signal("beat", beatposition)
	#draw on big side too
	
func _on_Conductor_start():
	play()


func _on_ClipScroller_add_beat(position):
	emit_signal("add_beat",position)
