class_name Fireball
extends Projectile

@export var bounce_vel = 5

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.y = bounce_vel
		bounce_vel = bounce_vel / 2
	else:
		velocity += get_gravity() * delta
	move_and_slide()
