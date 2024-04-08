extends Control
func _ready():
	#print(rect_position)
	rect_position.x = get_viewport_rect().size.x / 2
	rect_position.y = get_viewport_rect().size.y / 2
	Events.connect("hover", self, "hover" )
	#print(rect_position)

var monitoring = false

func _input(_event):
	if Input.is_action_just_pressed("ui_tap"):
		Events.emit_signal("click")


func bypass_bitch(code):
	var area = $cursor_area.get_overlapping_areas()
	
	var size = code.size()
	var areasize = area.size()
	#print("codesize: "+String(size)+" areasize:"+String(area.size()))
	if(size==0):
		#print("area entered")
		#print(area)
		hoverate(area)
	
	elif(size ==2 and areasize ==1):
		#print("overlap exit")
		var wr = weakref(code[size-1])
		if(!wr.get_ref()):
			pass
		elif(code[size-1]!=null):
			code[size-1].get_parent().hover_exit()
		bypass_bitch([])
	
	elif((size==1 or size ==2 or size==3) and areasize==0):
		#print("normal exit")
		var wr = weakref(code[size-1])
		if(!wr.get_ref()):
			pass
		else:
			simple_unhover(code)
		
#	elif(size > areasize and areasize > 1):
#		#print("code size: "+String(size)+" area size:"+String(area.size()))
#		print("overlap exit")
#		#print(code)
#		code[size-1].get_parent().hover_exit()
#		bypass_bitch([])
	
	if(size == areasize):
		#print("probably scored?")
		area.pop_back()
		hoverate(area)
			
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
			
func simple_unhover(me):
	for i in me:
		if i==$_NULL:
			i.get_parent().hover_exit()
	
var oldnews
func _on_cursor_area_area_entered(_area):
	#print("entered")
	oldnews = $cursor_area.get_overlapping_areas()
	bypass_bitch([])



func _on_cursor_area_area_exited(_area):
	#print("exited")
	bypass_bitch(oldnews)
