extends Node2D

var _score_perfect := 10
var _score_great := 5
var _score_ok := 3

const margin = .2
var _offset_perfect := 1
var _offset_great := 2
var _offset_ok := 4

var order_number := 0 setget set_order_number

var beat_time = 0
var _beat_hit := false
var _beat_miss = false
var _beat_delay := 4.0  #beats before perfect
var _speed := 0.0

onready var _animation_player := $AnimationPlayer
onready var _sprite := $Sprite
onready var _touch_area := $Area2D
onready var _label := $LabelCustom
onready var target_sphere = $Sprite/TargetSphere
onready var timer = $Timer
func _ready() -> void:
	_animation_player.play("show")
	Events.connect("click", self, "click")


func setup(data):
	self.order_number = data[0]
	_speed = data[1]
	_beat_delay = data[2]
	target_sphere.setup(data[2])
	beat_time = data[3]
	spawn_next_line()
	#find partner, print
	if (_beat_delay > 0):
		timer.wait_time = data[2]+margin
		timer.start()
	else: print("ERROR. TIME CANNOT BE ZERO")
	
func spawn_next_line():
	var next_placer = get_parent().get_parent().get_child(order_number)
	if(next_placer!=null):
		#Position2D Vector2
		var dist = abs((get_parent().position-next_placer.position).length())
		#print(global_position)
		print(dist)
		if(dist>600): 
		#var fuck = next_placer.global_position
		#print(newpos)
			$Line2D.points[1] = .65*(-global_position+next_placer.global_position)
		#$Line2D.global_position = Vector2.ZERO
		#print($Line2D.global_position)
		

func set_order_number(number: int) -> void:
	order_number = number
	_label.text = str(order_number)

func _process(delta: float) -> void:
	if _beat_hit:
		return
		hit()
		
func click():
	#print("hovering: " + String(hovering))
	if (hovering):
		hit()
	

func miss():
	if(_beat_hit == false):
		hovering = false
		_beat_miss = true
		_animation_player.play("miss")
		
func hit():
	if(_beat_miss==false and hovering == true):
		_beat_hit = true
		_animation_player.play("hit")
		#$Area2D.monitorable= false
		#$Area2D.monitoring = false
		score(beat_time)
		
		#send score to beatspawner. bs then gets the offset, and spawns / plays different animations (miss, good, great, perfect, etc). it also adds these to the score
		#print("HitBeat sending score!")

func score(time):
	#print("score! "+ String(time))
	Events.emit_signal("score", time)

func _on_Timer_timeout():
	#print("Timeout!")
	miss()

func hover():
	hovering = true
	_sprite.frame = 3

func hover_exit():
	hovering = false
	_sprite.frame = 0


var hovering = false
#discon
func _on_Area2D_area_entered(area):
	#print("AHHH"+area.name)
	pass

#discon
func _on_Area2D_area_exited(area):
	pass # Replace with function body.
