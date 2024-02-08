extends HScrollBar
export(NodePath) var scrub_rect_path

onready var scrub_rect = get_node(scrub_rect_path)



func _ready():
	pass # Replace with function body.



func _on_ScrubRect_item_rect_changed():
	rect_scale.x = (rect_size.x/scrub_rect.rect_size.x)
	rect_global_position.x = -scrub_rect.rect_global_position.x
