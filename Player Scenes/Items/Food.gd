extends RigidBody

export var just_fired = false


export var Food_value = 50
const SPEED = 10

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	if just_fired:
		shoot()
		
func shoot():
	apply_impulse(transform.basis.z, -transform.basis.z * SPEED)
	just_fired = false

func _on_Area_body_entered(body):
	if body.is_in_group("Toddler"):
		body.hunger += Food_value
		queue_free()
	elif body.is_in_group("Player"):
		body.food += 1
		queue_free()
	
func feed(body):
	body.targetstat += Food_value
