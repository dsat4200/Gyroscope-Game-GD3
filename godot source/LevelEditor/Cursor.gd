extends Control
signal click
func _ready():
	print(rect_position)
	rect_position.x = get_viewport_rect().size.x / 2
	rect_position.y = get_viewport_rect().size.y / 2
	Events.connect("hover", self, "hover" )
	print(rect_position)

var monitoring = false


#var last_hover
var current_hover

func _input(event):
	if Input.is_action_just_pressed("ui_tap"):
		Events.emit_signal("click")
		#call_deferred("toggle_monitor", false)
		

func hover(msg):
	print("hover!")
	
	#if already hovering over something, unhover it?
	if(current_hover!=null):
		print("overlap!")
		hover_exit(current_hover)
		
	current_hover = msg.get_parent()
	print(current_hover)
	current_hover.hover()
	pass
#lasthover, currenthover
#connect to events
#when collision, recieve signal, hovered = currenthover
#when exit, recieve signal, lasthover = currenthover, currenthover = null
#when click, send click signal if with currenthover (recieve in conductor?
#in hitbeat, on click signal, check name. if not equal, ignore
#if equal, destroy
func hover_exit(input):
	var msg
	if (input.name != "HitBeat"):
		msg = input.get_parent()
	else: msg = input
	#print(current_hover)
	#print(msg)
	
	#if no longer hovering over current, unhover
	if (msg == current_hover):
		print("unhover!")
		print(msg)
		#print("hover exited: "+String(current_hover))
		current_hover.hover_exit()
		#last_hover = current_hover
		current_hover = null
	
	
	

func _on_cursor_area_area_entered(area):
	hover(area)


func _on_cursor_area_area_exited(area):
	hover_exit(area)
