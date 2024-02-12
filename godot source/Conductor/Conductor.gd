extends AudioStreamPlayer

export var bpm := 117
export var measures := 4

# Tracking the beat and song position
export(NodePath) var beats_path
onready var beats = get_node(beats_path).get_pure_beats()

var song_position = 0.0
var song_position_in_beats = 0

var next_beat_index = 0
onready var next_beat_pos = beats[next_beat_index]

onready var sec_per_beat = 60.0 / bpm
var last_reported_beat_pos = 0.0
var last_reported_beat_index = 0

var beats_before_start = 0
var measure = 1


# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0

signal beat(position)
signal measure(position)
signal start

#add function to show beats it calculated?z

func _init():
	print("INIT!")

func _ready():
	print("READY!")
#	print("beats: "+String(beats))
#	print("first beat at: "+String(next_beat_pos))
#	next_beat_pos = beats[next_beat_index]
	


func _physics_process(_delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		if(song_position >= next_beat_pos):
			song_position_in_beats = next_beat_pos
		#print("song_pos: "+String(song_position)+". in beats: "+String(song_position_in_beats)+" next_pos: "+String(next_beat_pos)+" at index"+String(next_beat_index))
		_report_beat()


func _report_beat():
	#print("last beat:"+String(last_reported_beat)+", pos: "+String(song_position_in_beats))
	
	if last_reported_beat_pos < song_position_in_beats and song_position > 0:
		if measure > measures:
			measure = 1
		emit_signal("beat", song_position_in_beats)
		emit_signal("measure", measure)
		last_reported_beat_pos = song_position_in_beats
		if(next_beat_index < beats.size()-1):
			next_beat_index+=1
			next_beat_pos = beats[next_beat_index]
			measure += 1
			print("beat!"+String(song_position_in_beats))
		else:(print("last beat!"))

func play_with_beat_offset(num):
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()

func closest_beat(pos, nth):
	closest = int(round((pos / sec_per_beat) / nth) * nth) 
	time_off_beat = closest * sec_per_beat - pos
	print("nth: "+ String(nth)+"closest: "+ String(closest)+", off by: "+String(time_off_beat))
	return Vector2(closest, time_off_beat)

func play_from_nearest_beat(pos):
	var close = closest_beat(pos, 1)
	play_from_beat(int(close[0]), 0)

func play_from_beat(beat, offset):
	play()
	seek_fix(beat * sec_per_beat)
	beats_before_start = offset
	measure = beat % measures

func play_from_timecode(time):
	play()
	seek_fix(time)

func seek_fix(time):
	seek(time)
	
	#calculate and reset beat values?
	
func _on_StartTimer_timeout():
	song_position_in_beats += 1
	print("song_pos: "+String(song_position)+". in beats: "+String(song_position_in_beats))
	if song_position_in_beats < beats_before_start - 1:
		$StartTimer.start()
	elif song_position_in_beats == beats_before_start - 1:
		$StartTimer.wait_time = $StartTimer.wait_time - (AudioServer.get_time_to_next_mix() +
														AudioServer.get_output_latency())
		$StartTimer.start()
	else:
		play()
		emit_signal("start")
		#create start signal for things to link to
		$StartTimer.stop()
	_report_beat()
