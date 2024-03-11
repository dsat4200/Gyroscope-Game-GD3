extends Control

onready var left_scrub = $LeftScrub
onready var right_scrub = $RightScrub
onready var scrub_rect = $ScrubRect

onready var max_p = $RightScrub.rect_global_position.x
onready var min_p = $LeftScrub.rect_global_position.x

onready var max_scrub_rect_size = $ScrubRect.rect_size.x

signal scrub_changed
signal rect_changed

signal col_enter(body)
signal col_exit(body)

var r_hover = false
var l_hover = false
var rect_hover = false

var r_select = false
var l_select = false
var rect_select = false

var scrubbing = false
var scrub_offset = 0.0

func set_hand(b):
	if b:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _input(event):
	if Input.is_action_just_pressed("ui_tap") and l_hover:#on press, move the bars
		l_select = true
		set_hand(true)
	if Input.is_action_just_released("ui_tap") and l_hover:#on press, move the bars
		l_select = false
		set_hand(false)
	if Input.is_action_just_pressed("ui_tap") and r_hover:#on press, move the bars
		r_select = true
		set_hand(true)
	if Input.is_action_just_released("ui_tap") and r_hover:#on press, move the bars
		r_select = false
		set_hand(false)
	if Input.is_action_just_pressed("ui_tap") and rect_hover:#on press, move the bars
		rect_select = true
		set_hand(true)
	if Input.is_action_just_released("ui_tap") and rect_hover:#on press, move the bars
		rect_select = false
		scrubbing = false
		set_hand(false)
	
	if event is InputEventMouseMotion and l_select:
		var offset = event.position.x
		left_scrub.rect_global_position.x = offset
		if(check_bounds()): left_scrub.rect_global_position.x = right_scrub.rect_global_position.x	
		scale_rect()
	if event is InputEventMouseMotion and r_select:
		var offset = event.position.x
		right_scrub.rect_global_position.x = offset
		if(check_bounds()): right_scrub.rect_global_position.x = left_scrub.rect_global_position.x
		scale_rect()	
	if event is InputEventMouseMotion and rect_select:
		var offset = event.position.x - rect_position.x
		if scrubbing == false:
			scrub_offset = offset
			scrubbing = true
		else:
			#print("offset:"+String(offset)+" scrub_offset:"+String(scrub_offset))
			offset-=scrub_offset
			rect_position.x+=offset
		check_bounds()
		scale_rect()
	
func check_bounds() -> bool: 
	var lsp = left_scrub.rect_global_position.x
	var rsp = right_scrub.rect_global_position.x
	if  lsp < min_p:
		left_scrub.rect_global_position.x = min_p
	elif lsp > max_p:
		left_scrub.rect_global_position.x = max_p
	elif rsp > max_p:
		right_scrub.rect_global_position.x = max_p
	elif rsp < min_p:
		right_scrub.rect_global_position.x = min_p
	elif rsp < lsp:
		return true
	return false
	
func scale_rect():
	scrub_rect.rect_global_position.x = left_scrub.rect_global_position.x
	scrub_rect.rect_size.x = right_scrub.rect_global_position.x - left_scrub.rect_global_position.x


	
func _on_RightScrub_mouse_entered():
	r_hover = true
	print("r_hover: "+String(r_hover))
func _on_LeftScrub_mouse_entered():
	l_hover = true
	print("l_hover: "+String(l_hover))
func _on_RightScrub_mouse_exited():
	r_hover = false
	print("r_hover: "+String(r_hover))
func _on_LeftScrub_mouse_exited():
	l_hover = false
	print("l_hover: "+String(l_hover))
func _on_ScrubRect_mouse_entered():
	rect_hover = true
func _on_ScrubRect_mouse_exited():
	rect_hover = false


func _on_Scrub_item_rect_changed():
	emit_signal("scrub_changed")

#goal is this: when collided with guy, scale his dupe. 

func _on_ScrubRect_item_rect_changed():
	#change collision box
	$ScrubRect/col.scale.x = scrub_rect.rect_size.x/max_scrub_rect_size
	#print("area2d scale"+String($ScrubRect/collision.scale.x))
	emit_signal("rect_changed")


func _on_col_body_entered(body):
	emit_signal("col_enter", body.get_parent())


func _on_col_body_exited(body):
	emit_signal("col_exit", body.get_parent())
