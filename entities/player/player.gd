extends CharacterBody3D
class_name Player

@export var speed = 5
@export var jump_speed = 5
@export var mouse_sensitivity = 0.0025

@onready var health: Health = $Health
@onready var weapon_inventory : WeaponInventory = $WeaponInventory
@onready var footstep_sound : AudioStreamPlayer3D = $FootstepSound

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	health.health_depleted.connect(_on_health_depleted)
	Events.player_spawn.emit(self)

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	
	if (Vector2(velocity.x, velocity.z).length()) > 0 and is_on_floor():
		if !footstep_sound.playing:
			footstep_sound.play()
	else:
		footstep_sound.stop()

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func kill():
	get_tree().reload_current_scene()

func pickup_weapon(weapon_scene: PackedScene):
	weapon_inventory.add_to_inventory(weapon_scene)
	
func _on_health_depleted():
	Events.player_death.emit()
