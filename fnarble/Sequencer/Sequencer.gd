extends Control

# project settings > audio > enable audio input
export var clip : AudioStreamSample


func _ready():
	import_clip()

func import_clip():
	var s : AudioStreamSample = $ClipScroller.sample
	if s == null: s = clip
	else:
		var d = s.data
		d.append_array(clip.data)
		s.data = d
	$ClipScroller.sample = s
	$ClipScroller/Prompter.get_clip().sample = $ClipScroller.sample

func _process(_dt):
	if Input.is_action_just_released("ui_select"):
		if $ClipScroller.playing:
			$ClipScroller.stop()
			print("head stopped at:", $ClipScroller.head)
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
