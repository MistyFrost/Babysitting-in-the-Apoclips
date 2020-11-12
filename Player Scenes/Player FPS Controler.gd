extends KinematicBody


# controls camera Motion

var weapon_to_drop
var weapon_to_swap

onready var head = $Head
onready var ground_check = $"ground checker"
onready var hand = $Head/Hand
onready var reach = $Head/Camera/reach
onready var bread_slice_hr = preload("res://Player Scenes/Items/Bread Slice A HR.tscn")
onready var bread_slice = preload("res://Player Scenes/Items/Bread Slice A.tscn")
onready var bread_half_loaf_hr = preload("res://Player Scenes/Items/Bread Half Loaf HR.tscn")
onready var bread_half_loaf = preload("res://Player Scenes/Items/Bread Half Loaf.tscn")




export var mouse_sensitivity = 0.03
export var h_acceleration = 6
export var air_acceleration = 1
export var normal_acceleration = 6

export var gravity = 20
export var jump = 2


export var speed = 5

var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()

var full_contact = false




# -----------------------------------------------------------------------
func _process(_delta):
	if reach.is_colliding():
		if reach.get_collider().get_name() == "Bread Slice A":
			weapon_to_drop = bread_slice_hr.instance()
		elif reach.get_collider().get_name() == "Bread Half Loaf":
			weapon_to_drop = bread_half_loaf_hr.instance()
	else:
		weapon_to_drop = null
	if hand.get_child(0) != null:
		if hand.get_child(0).get_name() == "Bread Slice A HR":
			weapon_to_swap = bread_slice.instance()
		elif hand.get_child(0).get_name() == "Bread Half Loaf HR":
			weapon_to_swap = bread_half_loaf.instance()
	else:
		weapon_to_swap = null
	if Input.is_action_just_pressed("interact"):
		if weapon_to_drop != null:
			if hand.get_child(0) != null:
				get_parent().add_child(weapon_to_swap)
				weapon_to_swap.global_transform = hand.global_transform
				weapon_to_swap.dropped = true
				hand.get_child(0).queue_free()
			reach.get_collider().queue_free()
			hand.add_child(weapon_to_drop)
			weapon_to_drop.rotation = hand.rotation
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):

	Move_Body(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Rotate_Head(event)
		Rotate_Body(event)
		lock_head_rotation()

func Rotate_Body(event):
	rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

func Rotate_Head(event):
	head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))

func lock_head_rotation():
	head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func apply_gravity(delta):
	if ground_check.is_colliding():
		full_contact = true
	else:
		full_contact = false
		
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta
		h_acceleration = air_acceleration
	elif is_on_floor() and full_contact:
		gravity_vec = -get_floor_normal() * gravity
		h_acceleration = normal_acceleration
	else: 
		gravity_vec = -get_floor_normal()
		h_acceleration = normal_acceleration

func Jump():
	gravity_vec = Vector3.UP * jump

func normalize_direction():
	direction = direction.normalized()

func accelerate(delta):
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_acceleration * delta)

func Move_Body(delta):
	
	direction = Vector3()
	apply_gravity(delta)
	
	get_input()
	normalize_direction()
	accelerate(delta)
	combine_movment_and_gravity()
# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector3.UP, true)

func combine_movment_and_gravity():
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
func get_input():

	
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding()):
		Jump()
	
	if Input.is_action_pressed("move foward"):
		direction -= transform.basis.z 
	elif Input.is_action_pressed("move backward"):
		direction += transform.basis.z 
	if Input.is_action_pressed("move left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move right"):
		direction += transform.basis.x
	

	
