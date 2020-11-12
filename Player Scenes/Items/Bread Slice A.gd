extends RigidBody
var dropped : bool = false

func _ready():
	pass

func _process(delta):
	if dropped:
		apply_impulse(transform.basis.z, -transform.basis.z * 10 * delta)
		dropped = false

