extends Container
export(NodePath) var scrub_rect_path
onready var scrub_rect = get_node(scrub_rect_path)

export(NodePath) var scrub_path
onready var scrub = get_node(scrub_path)

onready var baseposition = rect_global_position.x

func _ready():
	pass # Replace with function body.


func update_scrub():
	if scrub_rect.rect_size.x != 0:
		var scalefactor = rect_size.x/scrub_rect.rect_size.x
		var offset = scalefactor * (baseposition - scrub_rect.rect_global_position.x)
		print("offset: " + String(offset))
		rect_global_position.x = baseposition + offset
		rect_scale.x = scalefactor
		
func _on_ScrubRect_item_rect_changed():
	update_scrub()

func _on_Scrub_item_rect_changed():
	update_scrub()
