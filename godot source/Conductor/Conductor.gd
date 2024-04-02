extends AudioStreamPlayer

export var bpm := 190
var measures := 4

onready var beats = get_pure_beats()

var song_position = 0.0

var last_reported_beat = 0
var song_position_in_beats = 0
var next_beat = 1

onready var sec_per_beat = 60.0 / bpm

var beats_before_start = 0
var measure = 1

# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0


signal beat(position)
signal measure(position)
signal start


export(Resource) var csv_path

onready var beat_file 


var hit_time

func _ready():
	Events.connect("score", self, "score")

func get_pure_beats() -> PoolRealArray:
	var markers = csv_path.records
	var data : PoolRealArray = []
	for N in markers:

		data.append(N[0])
	return data

func get_beat_cues() -> Array:
	var cues = csv_path.records

	return cues
	

func score(time):
	print("Score! Time: "+String(song_position)+" offset:"+ String(abs(song_position-time)))
	pass
func _process(_delta):
	if Input.is_action_just_pressed("middle_click"):
		pass

func _physics_process(_delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -=AudioServer.get_output_latency()
		#print(String(song_position))
		if(song_position >= beats[0]):
			#print("beat! "+String(song_position_in_beats)+" "+ String(song_position))
			emit_signal("beat", song_position_in_beats)
			song_position_in_beats+=1
			beats.remove(0)


func play_with_beat_offset(num):
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()

func closest_beat(pos, nth): # fix
	closest = int(round((pos / sec_per_beat) / nth) * nth) 
	time_off_beat = closest * sec_per_beat - pos
	#print("nth: "+ String(nth)+"closest: "+ String(closest)+", off by: "+String(time_off_beat))
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
	#print(String(song_position_in_beats))
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start - 1:
		$StartTimer.start()
	elif song_position_in_beats == beats_before_start - 1:
		$StartTimer.wait_time = $StartTimer.wait_time - (AudioServer.get_time_to_next_mix() +
														AudioServer.get_output_latency())
		$StartTimer.start()
	else:
		play()
		song_position_in_beats = 1
		#print("last, current, next: " + String(last_reported_beat)+" "+String(song_position_in_beats)+" "+String(next_beat))
		emit_signal("start")
		#create start signal for things to link to
		$StartTimer.stop()
	#_report_beat()


func _on_Beats_beats_updated(in_beats):
	beats = in_beats
	
