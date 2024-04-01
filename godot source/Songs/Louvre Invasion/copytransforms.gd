extends Control
onready var parent = get_parent()

export(float) var movefactor = .3


func _process(delta):
	rect_position = (parent.rect_position*movefactor)
