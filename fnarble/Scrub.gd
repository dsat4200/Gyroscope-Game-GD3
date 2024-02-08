extends ColorRect

onready var scrub_rect = $ScrubRect
onready var right_scrub = $RightScrub

var r_hover = false
var l_hover = false

export(bool) var lr #left 0, right 1

func _input(event):
	if Input.action_press("ui_scrub") and l_hover:#on press, move the bars
		var offset = rect_global_position.x - event.position.x
		rect_position.x += offset
		right_scrub.rect_position.x -=offset


func _ready():
	pass # Replace with function body.

#click and drag, send signal of position to cS. cS converts that position to time, allowing for stretching of the audio track.



#bindings
func _on_RightScrub_mouse_entered():
	r_hover = true
func _on_LeftScrub_mouse_entered():
	l_hover = true
func _on_RightScrub_mouse_exited():
	r_hover = false
func _on_LeftScrub_mouse_exited():
	l_hover = false
