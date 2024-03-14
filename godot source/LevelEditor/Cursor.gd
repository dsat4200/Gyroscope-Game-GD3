extends Control
signal click
func _ready():
	print(rect_position)
	rect_position.x = get_viewport_rect().size.x / 2
	rect_position.y = get_viewport_rect().size.y / 2
	Events.connect("hover", self, "hover" )
	print(rect_position)

var monitoring = false


var last_hover
var current_hover

func _input(event):
	if Input.is_action_just_pressed("ui_tap"):
		Events.emit_signal("click")
		#if hovering over something, stop.
		if(current_hover!=null):
			#hover_exit(current_hover)
			print("clicked! stop hovering")
		#call_deferred("toggle_monitor", false)
		

func hover(msg):
	#print("hover!")
	
	#if already hovering over something, unhover it?
	if(current_hover!=null):
		last_hover = current_hover
		#print("overlap!")
		#unhover
		hover_exit(current_hover)
		current_hover = msg.get_parent()
		current_hover.hover()
		
	if(current_hover == null):
		current_hover = msg.get_parent()
		#print(current_hover)
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
		#print("unhover!")
		#print(msg)
		#print("hover exited: "+String(current_hover))
		current_hover.hover_exit()
		
		#if still secretly hovering over something, stop
		var area = $cursor_area.get_overlapping_areas()
		if($cursor_area.get_overlapping_areas().size() == 1):
			print("still hovering!")
			
			var temp = last_hover
			last_hover = current_hover
			current_hover = temp
			current_hover.hover()
			
		else:
			simple_unhover()
			
		
		#current_hover = hover_me

func simple_unhover():
	print("simple_unhover")
	last_hover = current_hover
	current_hover = null
		
		
	#print("overlaps with "+String($cursor_area.get_overlapping_areas()))
	
	
	

func bypass_bitch(code):
	#hoverate($cursor_area.get_overlapping_areas())
	print("code size"+String(code.size()))
	var area = $cursor_area.get_overlapping_areas()
	if(code.size()==0):
		#print("area entered")
		#print(area)
		hoverate(area)
	
	if(code.size() > area.size()):
		print("overlap exit")
		#print(code)
		code[code.size()-1].get_parent().hover_exit()
		bypass_bitch([])

			
func hoverate(me):
	for i in len(me):
		#print(i)
		var j = me[i].get_parent()
		if i < len(me)-1:
			#print("unhovering!")
			#print(j)
			j.hover_exit()
		else:
			#print("hovering!")
			#print(j)
			j.hover()
		
var oldnews
func _on_cursor_area_area_entered(area):
	print("entered")
	oldnews = $cursor_area.get_overlapping_areas()
	bypass_bitch([])
	#hover(area)


func _on_cursor_area_area_exited(area):
	print("exited")
	bypass_bitch(oldnews)
	#hover_exit(area)
