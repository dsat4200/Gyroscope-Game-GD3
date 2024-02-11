extends Container

export var sample : AudioStreamSample setget _set_sample,_get_sample
export var start  : float = 0.0
export var end    : float = 0.0
export var head   : float = 0.0 setget _set_head
export var timeScale : int = 128 setget _set_timeScale, _get_timeScale
var conductor


onready var clipNode = $ClipContainer/AudioClip
onready var headNode = $ClipContainer/PlayHead
onready var hoverNode = $ClipContainer/HoverHead
onready var timelineNode = $Prompter/card/clip

onready var big_hover_head = $Prompter/card/BigScrub
onready var big_play_head = $Prompter/card/BigPlayHead

onready var beats = $ClipContainer/beats
onready var big_beats = $Prompter/card/BigBeats

var playing = false
var mix_rate = 44100


func _set_timeScale(x):
	clipNode.timeScale = x
	timelineNode.timeScale = x

func _get_timeScale():
	#print("get timescale!")
	#print("CS ts:"+String(timeScale) + ", but CN ts is"+String(clipNode.timeScale))
	return clipNode.timeScale

func _set_sample(x):
	start = 0.0
	self.head = start
	end = 0.0 if x == null else x.get_length()
	mix_rate = 44100 if x == null else x.mix_rate
	clipNode.sample = x
	
	timeScale = (clipNode.sample.get_length()*mix_rate)/rect_size.x
	clipNode.timeScale = (clipNode.sample.get_length()*mix_rate)/rect_size.x
	timelineNode.timeScale = (clipNode.sample.get_length()*mix_rate)/rect_size.x
	
func _get_sample():
	return clipNode.sample

func _set_head(x):
	head = x
	headNode.rect_position.x = timeToPixels(x)
	big_play_head.rect_position.x = headNode.rect_position.x

func play():
	if head >= end: head = start
	playing = true
	#conductor.stream = clipNode.sample
	#print("end is:", end)
	#print("length is:", clipNode.sample.get_length())
	#print("playing from ", head)
	#conductor.play(head)
	#replace with signal to play?
	yield(conductor, "finished")

func stop():
	self.playing = false
	#conductor.stop()

func timeToPixels(t:float) -> float:
		#print(String(t)+" * " + String(mix_rate)+" / "+String(timeScale) + "= "+String(t*mix_rate/timeScale))
		return t * mix_rate / timeScale

func pixelsToTime(px:float) -> float:
	#print(String(px)+" * " + String(timeScale)+" / "+String(mix_rate))
	return px * timeScale / mix_rate

func _input(event): 
	if event is InputEventMouseMotion and hover:
		hoverNode.rect_global_position.x = event.position.x
	if event is InputEventMouseMotion and hover_nav:
		big_hover_head.rect_global_position.x = event.position.x
		hoverNode.rect_position.x = big_hover_head.rect_position.x
		
	if Input.is_action_just_pressed("ui_tap") and (hover or hover_nav):
		#print(String(self.head))
		#self.head = pixelsToTime(hoverNode.rect_global_position.x - rect_position.x)
		play_from_timecode(pixelsToTime(hoverNode.rect_position.x))
		#replace with signal to stop?
		#replace with signal to play

func play_from_timecode(pos):
	conductor.play_from_timecode(pos)
	
func _process(dt):
	if playing:
		self.head = conductor.song_position #if playing, head is set to song_pos
#		if self.head > self.end:
#			playing = false

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


func _on_card_mouse_exited():
	hover_nav = false

func _on_card_item_rect_changed():
	pass # Replace with function body.
	
func _on_sequencer_beat(beatposition):
	#get control, then position big beat?
	var newbeat = draw_beatmarker(beatposition, timeToPixels(conductor.song_position))
	
func draw_beatmarker(beatposition, songpos): #makes and gets the control
	#print("beat! pos: "+String(beatposition)+", time: "+String(songpos))
	if (beatposition > 0):
		#rename small, set position. then, duplicate small, scale it up, and move it to big
	
		#first is always small
		var dupe := beats.get_child(0) as ColorRect
		#print(String(beatposition)
		#print(beats.get_child(0).name)
		dupe.rect_position.x = songpos
		
		var small = dupe.duplicate()
		small.set("s_", beatposition)
		
		#print(small.get_child(0).text+ "at "+ String(small.get_child(0).rect_global_position.x))
		var big = dupe.duplicate() 
		big.set("b_", beatposition)
		big.rect_size.y = big_play_head.rect_size.y
		
		#big.get_child(0).text = String(beatposition)
		beats.add_child(small)
		big_beats.add_child(big)
		
		
		#print(newsmall.name+ "and big "+ String(newbig.name)
		
		#newsmall.get_node("num").text = beatposition
		#newbig.get_node("num").text = beatposition
		
		#second dupe gets a fucked up name, not sure why
		
		
		#print("big: "+ String(big.beat)+" small: "+String(small.beat))
	
		
		#print("small beat: "+small.name+", big beat: "+big.name)
		
		small.visible = true
		big.visible = true
		
#try this later https://forum.godotengine.org/t/how-do-i-check-if-a-specific-object-is-overlapping-an-area2d-every-frame/6944/3
#for now, area2d overlap is fine

