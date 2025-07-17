extends CharacterBody3D
class_name Player

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002

@onready var weapon : Weapon = $Camera3D/WeaponHolster/Weapon
@onready var health: Health = $Health

func _ready():
	set_player_status()

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	
	if event.is_action_pressed("shoot"):
		weapon.fire_weapon(-$Camera3D.global_basis.z)

func kill():
	get_tree().reload_current_scene()

func set_player_status():
	#get_tree().call_group("enemies", "set_player", self)
	GameManager.set_player(self)
