extends Control
signal click
func _ready():
	#print(rect_position)
	rect_position.x = get_viewport_rect().size.x / 2
	rect_position.y = get_viewport_rect().size.y / 2
	#print(rect_position)

var monitoring = false

func _input(event):
	if Input.is_action_just_pressed("ui_tap"):
		Events.emit_signal("click")
		#call_deferred("toggle_monitor", false)
		


