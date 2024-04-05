tool
extends Control
var hitbeats



export (bool) var _btn_save_beat_positions
export (bool) var _btn_load_beat_positions
#
#
#
func btn_save_beat_positions():
	save_position_data()
#
func btn_load_beat_positions():
	load_position_data()
	#load_position_data()
#
export(String) var file_name
	
func hitbeats() -> Node:
	return get_parent().find_node("HitBeats")

func get_file_path()->String:
	if not Engine.editor_hint:
		return 	"user://"+file_name+".txt"
	else:
		return get_tree().edited_scene_root.filename.get_base_dir()+"/"+file_name+".txt"

	
func _input(event):
	if event.is_action_pressed("save") and not Engine.editor_hint:
		save_position_data()
	if event.is_action_pressed("reload_beat_positions") and not Engine.editor_hint:
		load_position_data()
func save_position_data():
	var file = File.new()
	file.open(get_file_path(), File.WRITE)
	var hitbeats = hitbeats()
	for i in range(hitbeats.get_child_count()):	
		file.store_string(String(hitbeats.get_child(i).position)+"\n")
	file.close()

func parse_position(line: String) -> Vector2:
	var parts = line.split(",")
	if parts.size() >= 2:
		var x = parts[0].to_int()
		var y = parts[1].to_int()
		return Vector2(x, y)
	return Vector2.ZERO

func load_position_data():
	var file = File.new()
	if file.file_exists(get_file_path()):
		file.open(get_file_path(), File.READ)
		var lines = file.get_as_text().split("\n") # Split text into lines
		file.close()
		
		var hitbeats_node = hitbeats() # Assuming this is a function returning the hitbeats node
		if hitbeats_node != null:
			for i in range(min(lines.size(), hitbeats_node.get_child_count())):
				var line = lines[i]
				var child_node = hitbeats_node.get_child(i)
				if child_node != null:
					var pos = parse_position(line)
					child_node.position = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

