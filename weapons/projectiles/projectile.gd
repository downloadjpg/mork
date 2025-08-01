class_name Projectile extends CharacterBody3D

@export var lifetime : float = 3.0
@export var gravity_scale : float = 0.0
@export var damage : int = 1
@export var initial_speed: float = 20.0
@export var damage_source : Node3D

var elapsed_time: float = 0.0
var initial_direction: Vector3

@onready var hitbox = get_node_or_null("HitBox")

func _ready() -> void:
	if lifetime > 0:
		await get_tree().create_timer(lifetime).timeout
		queue_free()

func initialize(source, damage_value = 10, projectile_speed = 20.0, projectile_gravity = 0.0):
	# Set source and damage
	damage_source = source
	damage = damage_value
	initial_speed = projectile_speed
	gravity_scale = projectile_gravity

	# Set hitbox properties
	if hitbox:
		hitbox.damage = damage
		hitbox.damage_source = source

	# Set initial direction and velocity
	initial_direction = -global_transform.basis.z
	velocity = initial_direction * initial_speed

func _physics_process(delta):
	# Track lifetime
	elapsed_time += delta

	# Apply gravity if enabled
	if gravity_scale > 0:
		velocity.y -= 9.8 * gravity_scale * delta

	# Move and handle collisions
	var collision = move_and_collide(velocity * delta)
	if collision:
		on_collision(collision)

func on_collision(_collision):
	pass
