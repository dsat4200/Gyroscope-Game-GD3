extends Spatial

export(NodePath) var videopath
onready var video = get_node(videopath)

func _on_3d_view_start():
	video.play()
