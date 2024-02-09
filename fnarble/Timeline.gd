extends Container
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

func _input(event): 
	if event is InputEventMouseMotion and hover:
		hover_head.rect_global_position.x = event.position.x
		small_hover_head.rect_position.x = (hover_head.rect_position.x)

func small_to_big(f:float) -> float:
	scalefactor = rect_size.x/scrub_rect.rect_size.x
	return scalefactor * (baseposition - f)
	



func update_scrub():
	if scrub_rect.rect_size.x != 0:
		move_to_scale(scrub_rect, self)
		rect_scale.x = scalefactor
		hover_head.rect_scale.x = 1/scalefactor
		play_head.rect_scale.x = 1/scalefactor
		#print("hover head scale:"+String(hover_head.rect_scale.x))
		
		
func move_to_scale(from, to):
	var offset = small_to_big(from.rect_global_position.x)
	#print("small: "+String(from.rect_global_position.x)+"to big:" + String(baseposition+offset))
	to.rect_global_position.x = baseposition + offset
	
func _on_ScrubRect_item_rect_changed():
	update_scrub()

func _on_Scrub_item_rect_changed():
	update_scrub()



func _on_card_mouse_entered():
	hover = true
	#print(String(hover))


func _on_card_mouse_exited():
	hover = false
	#print(String(hover))
