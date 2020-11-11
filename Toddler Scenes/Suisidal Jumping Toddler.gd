extends KinematicBody
var space_state
var speed = 10
func _ready():
	space_state = get_world().direct_space_state
	pass
var target
func _physics_process(delta):
	apply_gravity(delta)
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP * delta)
			set_color(Color(0, 0, 0))
			move_to_target(delta)
		else:
			set_color(Color(0, 0, 1))
	move_and_slide(gravity_vec, Vector3.DOWN, true)

func _on_Sight_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print("body spot")

		set_color(Color(0, 0, 0))


func _on_Sight_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print("body spot")
		
		set_color(Color(1, 0, 0))

func set_color(color):
	$Body/Face.get_surface_material(0).set_albedo(color)
	
func move_to_target(delta):
	gravity_vec = (target.transform.origin + transform.origin.normalized()) 
var gravity = 20
onready var ground_check = $RayCast
var full_contact
var gravity_vec

func apply_gravity(delta):
	
	if ground_check.is_colliding():
		full_contact = true
	else:
		full_contact = false

	if not is_on_floor():
		gravity_vec = Vector3(0, -gravity, 0) * gravity * delta

	elif is_on_floor() and full_contact:
		gravity_vec = -get_floor_normal() * gravity

	else: 
		gravity_vec = -get_floor_normal()


	
