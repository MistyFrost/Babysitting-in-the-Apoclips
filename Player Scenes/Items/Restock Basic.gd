extends Spatial

signal Food_added

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("Open Door")
		
		



func _on_Area_body_exited(body):
	body.food += 10
	emit_signal("Food_added")
	$AnimationPlayer.play_backwards("Open Door")
	

