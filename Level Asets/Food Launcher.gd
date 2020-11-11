extends Spatial


onready var projectile = preload("res://Player Scenes/Items/Bread Half.tscn")
onready var launch_point = $"mesh/Launch Point"
onready var aim = $"mesh/Launch Point/Aim"
func _input(event):
	if event.is_action_pressed("shoot"):
		if $"../../../../Player FPS Controler".food >= 0:
			var p = projectile.instance()
			launch_point.add_child(p)
			p.look_at(aim.get_collision_point(), Vector3.UP)
			p.just_fired = true
			$"../../../../Player FPS Controler".food -= 1
