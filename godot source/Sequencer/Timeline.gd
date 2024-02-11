extends Control

export(NodePath) var scrub_rect_path
onready var scrub_rect = get_node(scrub_rect_path)

export(NodePath) var small_play_head_path
onready var small_play_head = get_node(small_play_head_path)

export(NodePath) var small_hover_head_path
onready var small_hover_head = get_node(small_hover_head_path)

onready var play_head = $BigPlayHead
onready var hover_head = $BigScrub

var hover


onready var baseposition = rect_global_position.x
var scalefactor = 1.0

func _ready():
	pass # Replace with function body.


func small_to_big(f:float) -> float:
	scalefactor = rect_size.x/scrub_rect.rect_size.x
	return scalefactor * (baseposition - f)
	



func update_scrub():
	if scrub_rect.rect_size.x != 0:
		move_to_scale(scrub_rect, self)
		rect_scale.x = scalefactor
		hover_head.rect_scale.x = 1/scalefactor
		play_head.rect_scale.x = 1/scalefactor
		
		#scale beat arraylist
		
		
		#print("hover head scale:"+String(hover_head.rect_scale.x))
		
		
func move_to_scale(from, to):
	var offset = small_to_big(from.rect_global_position.x)
	#print("small: "+String(from.rect_global_position.x)+"to big:" + String(baseposition+offset))
	to.rect_global_position.x = baseposition + offset
	

func _on_card_mouse_entered():
	hover = true
	#print(String(hover))

func _on_card_mouse_exited():
	hover = false
	#print(String(hover))

func _on_Scrub_scrub_changed():
	update_scrub()


func _on_Scrub_rect_changed():
	update_scrub()

func get_big_beat(i:int) -> Node2D: #dangerous stupid bitch of a method
	#print("big beat: "+$BigBeats.get_child(i-1).name)
	print("bbcount: "+String($BigBeats.get_child_count())+"index: "+String(i))
	var big = $BigBeats.get_child(i-1)
	if(big == null):
		print("FFFFUCK YOU STUPID BITCH! "+String($BigBeats.get_child_count())+", "+String(i))
		return null
	
	else:
		print(big.name+", "+String(i))
		return big
	
func _on_Scrub_col_enter(body):
	#body.get_parent().link.rect_scale.x = 1/scalefactor
	var big = get_big_beat(body.beat)
	if (big!= null):
		big.rect_scale.x = 1/scalefactor

func _on_Scrub_col_exit(body):
	#print("body exit: "+body.name)
	pass # Replace with function body.
