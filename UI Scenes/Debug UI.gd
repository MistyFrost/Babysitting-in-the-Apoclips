extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_captured = true

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("ui_home"):
		get_tree().paused = not get_tree().paused
		
		$"Pause Wndow".visible = not $"Pause Wndow".visible
		
		
		if mouse_captured == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse_captured = false
		else:
			mouse_captured = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
