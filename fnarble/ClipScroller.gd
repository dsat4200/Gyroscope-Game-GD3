extends ScrollContainer

export var sample : AudioStreamSample setget _set_sample,_get_sample
export var start  : float = 0.0
export var end    : float = 0.0
export var head   : float = 0.0 setget _set_head
export var timeScale : int = 128 setget _set_timeScale, _get_timeScale

onready var clipNode = $ClipContainer/AudioClip
onready var headNode = $ClipContainer/PlayHead
onready var hoverNode = $ClipContainer/HoverHead

var playing = false
var mix_rate = 44100


func _set_timeScale(x):
	clipNode.timeScale = x

func _get_timeScale():
	return clipNode.timeScale

func _set_sample(x):
	start = 0.0
	self.head = start
	end = 0.0 if x == null else x.get_length()
	mix_rate = 44100 if x == null else x.mix_rate
	clipNode.sample = x

func _get_sample():
	return clipNode.sample

func _set_head(x):
	head = x
	headNode.rect_position.x = timeToPixels(x)

func play():
	if head >= end: head = start
	playing = true
	$AudioStreamPlayer.stream = clipNode.sample
	print("end is:", end)
	print("length is:", clipNode.sample.get_length())
	print("playing from ", head)
	$AudioStreamPlayer.play(head)
	yield($AudioStreamPlayer, "finished")

func stop():
	self.playing = false
	$AudioStreamPlayer.stop()

func timeToPixels(t:float) -> float:
	return t * mix_rate / timeScale

func pixelsToTime(px:float) -> float:
	return px * timeScale / mix_rate

func _input(event): #change. if hovering, move scrub head. if released, move playhead and play
	if event is InputEventMouseMotion and hover:
		hoverNode.rect_global_position.x = event.position.x
	if Input.is_action_just_pressed("ui_scrub") and hover_nav:
			self.head = pixelsToTime(event.position.x - rect_position.x)
			stop()
			play()	
	if Input.is_action_just_pressed("ui_scrub") and hover:
			self.head = pixelsToTime(event.position.x - rect_position.x)
			stop()
			play()	

func _process(dt):
	if playing:
		self.head += dt
		if self.head > self.end:
			playing = false

var hover = false
var hover_nav = false

func _on_ClipScroller_mouse_entered():
	hover = true
	#print("hover: "+String(hover))


func _on_ClipScroller_mouse_exited():
	hover = false
	#print("hover: "+String(hover))


func _on_card_mouse_entered():
	hover_nav = true
	#print("hover_nav: "+String(hover_nav))


func _on_card_mouse_exited():
	hover_nav = false
	#print("hover_nav: "+String(hover_nav))
