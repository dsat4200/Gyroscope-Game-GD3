tool
extends Node

class_name beat

enum TYPE {ARRAY, SLIDE, SINGLE, GESTURE}

export(TYPE) var type

export var order : int = 0 setget _set_order, _get_order

export(bool) var regularly_spaced = true


export var pos : PoolRealArray =  []

	
func add_pos(x):
	if(regularly_spaced):
		print("adding!")
		var size = pos.size()
		if(size == 0):
			pos.append(x)
		else:
			pos[size-1] = pos[size-2]+get_parent().sec_per_beat
		print("p added at:"+String(pos[size-1]))
	
	
func _set_order(x): #do this with parent instead
	if(get_parent() != null):
		get_parent().move_child(self, x)
		order = get_index()
		get_parent().update_names()
	
	

#		print(self.name)


		#update next name. if no next, dont.

func _get_order():
	return get_index()
