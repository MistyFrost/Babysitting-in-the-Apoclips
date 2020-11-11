extends Node


export var hunger : int

var starving

signal starving

func is_starving():
	if hunger <= 0:
		starving = true
		emit_signal("starving")
		
