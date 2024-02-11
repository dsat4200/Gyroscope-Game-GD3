extends Spatial

onready var video = $Sphere/Viewport/ViewportContainer/VideoPlayer


func _on_3d_view_start():
	video.play()
