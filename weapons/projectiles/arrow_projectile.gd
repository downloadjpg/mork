class_name Arrow extends Projectile

@export var stick_to_bodies: bool = true
@export var stick_to_walls: bool = true
#@export var penetration_power: float = 0.2 # How far it embeds

@onready var stick_point :Marker3D = $StickPoint # Where the arrow connects to whatever

var pinned = false
var pin_point : Vector3 
var collider : Node3D

func _physics_process(delta: float) -> void:
	if pinned:
		if pin_point:
			position = pin_point + collider.global_position
		return
	super(delta)
	# Make arrows rotate and follow their velocity
	if velocity != Vector3.ZERO:
		
	# If the projectile might travel straight up/down, handle that special case
		if abs(velocity.normalized().dot(Vector3.UP)) > 0.99:
			# Use a different up vector when traveling vertically
			look_at(position + velocity, Vector3.FORWARD)
	
		else:
			look_at(position + velocity, Vector3.UP)
	

func on_collision(collision):
	if pinned:
		return
	# Get collision info
	var collision_point = collision.get_position()
	#var collision_normal = collision.get_normal()
	collider = collision.get_collider()
	pin_point = (collision_point - stick_point.position)
	
	
	# Pin to whatever was hit
	pin()
	if collider is Player:
		await get_tree().create_timer(0.5).timeout
		queue_free()

	
func _on_collider_removed():
	pinned = false
	gravity_scale = 1.0
	$HitBox/CollisionShape3D.disabled = false
	$CollisionShape3D.disabled = false

func pin():
	pinned = true
	collider.tree_exited.connect(_on_collider_removed)
	velocity = Vector3.ZERO
	$HitBox/CollisionShape3D.disabled = true
	$CollisionShape3D.disabled = true
	
