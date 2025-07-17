class_name Arrow
extends Projectile


var stuck : bool = false

@export var gravity_multiplier: float = 0.3

func _physics_process(delta: float) -> void:
	# # Add the gravity.
	if not stuck:
		velocity += get_gravity() * delta * gravity_multiplier
	
	move_and_slide()

func _ready() -> void:
	super()
	$HitBox.body_entered.connect(_on_body_collision)

func _on_body_collision(body: Node3D):
	stuck = true
	velocity = Vector3.ZERO

func _process(delta: float) -> void:
	# Make sprite follow trajectory
	if velocity != Vector3.ZERO:
		look_at(position + velocity)
