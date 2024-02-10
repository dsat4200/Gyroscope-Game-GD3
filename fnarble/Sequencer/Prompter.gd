extends Node
# Prompter helps you record audio samples
# corresponding to text prompts.

export var root : String = "e:/audio/"
export var path : String = "lines"
export var cursor : int = 0 setget _set_cursor
export var sample : AudioStreamSample setget _set_sample, _get_sample
var clips : Array = []
var paths : Array = []

func clearCards():
	pass

func _get_sample():
	return get_clip().sample

func _set_sample(x):
	get_clip().sample = x

func _set_cursor(i):
	get_clip().active = false
	get_clip().active = true

func get_clip():
	return $card/clip

func _ready():
	clearCards()
	var c = $card.duplicate()
	c.visible = true
	c.get_node('clip').sample = null # AudioStreamSample.new()
	_set_cursor(0)

#func save_clip(i=-1):
#	if i == -1: i = cursor
#	var s : AudioStreamSample = get_clip(i).sample
#	s.save_to_wav(root + path + '/' + str(i))
