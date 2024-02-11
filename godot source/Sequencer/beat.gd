extends ColorRect
var link
var beat = 0

func set(name, pos):
	if name =="b_":
		$num.set("theme_override_colors/font_color",Color(1.0,0.0,0.0,1.0))
	name = name+String(pos)
	$num.text = String(pos)
	beat = pos
	
