extends Control

onready var grid = $Grid

func move(pos:Array):
	grid.position.x-=pos[0]
	grid.position.y-=pos[1]
	
