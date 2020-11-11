extends KinematicBody
export var hunger = 0

onready var crying = $Body/Face/AudioStreamPlayer3D
func _process(delta):
	if hunger >= 50:
		crying.play()
	
	elif hunger >= 100:
		crying.stop()
		hunger = 100
	

func die():
	emit_signal("died")
	queue_free()



func _on_Timer_timeout():
	hunger -= 1
	 # Replace with function body.
