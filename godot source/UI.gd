extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu
var menu_open = false

#CONTROL SETTINGS
var drag_input_enabled

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = $menu
	init_buttons()
	pass # Replace with function body.


func init_buttons():
	menu.connect("pressed", self, "_menu_pressed")
	menu.get_node("re_center").connect("pressed", self, "_re_center_pressed")
	menu.get_node("drag_input").connect("pressed", self, "_drag_input_pressed")

	
func toggle_menu() -> bool:
	if !menu_open:
		menu.text = "X"
	else:
		menu.text = "="
	
	menu_open = not menu_open
	get_tree().paused = menu_open
	menu.get_node("re_center").visible = menu_open
	menu.get_node("drag_input").visible = menu_open
	return menu_open

func pass_data(acc, grav, mag, gyro):
	get_node("data/Accelerometer").text = "A: " + acc + ", G: " + grav
	get_node("data/Magnetometer").text = "M: " + mag
	get_node("data/Gyroscope").text = "G: " + gyro

func _menu_pressed():
	toggle_menu()
	
func _re_center_pressed():
	get_tree().get_root().get_node("Main").zero_camera()
	
func _drag_input_pressed():
	drag_input_enabled = not drag_input_enabled
