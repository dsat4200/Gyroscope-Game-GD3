tool
extends Spatial
onready var closed = preload("res://Songs/NTHE/visuals/3d/fleur/Eye_Closed_Face.png")
onready var default = preload("res://Songs/NTHE/visuals/3d/fleur/Face.png")
onready var dizzy = preload("res://Songs/NTHE/visuals/3d/fleur/Face_Spiral.png")
onready var mid_blink = preload("res://Songs/NTHE/visuals/3d/fleur/Mid_Blink_Face.png")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var expression : String = "default" setget _set_expression, _get_expression

func _set_expression(input:String):
	expression=input
	update_texture(expression)
# Called when the node enters the scene tree for the first time.

func _get_expression():
	return expression

func _ready():
	pass

func update_texture(input:String):
	var path = default
	match (input):
		"closed":
			path=closed
		"default":
			path=default
		"dizzy":
			path=dizzy
		"mid_blink":
			path=mid_blink
	$root/Skeleton/Cube002.get_mesh().get("surface_4/material").set_texture(SpatialMaterial.TEXTURE_ALBEDO, path)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
