extends CharacterBody3D
class_name Enemy

@onready var player_detection : PlayerDetection = $PlayerDetection 
@onready var new_wander_target_timer : Timer = $WanderTimer

@export var move_speed := 10.0
@export var detection_range := 10.0
@export var attack_range := 1.0

@onready var health = $Health
@onready var animation_player = $AnimationPlayer

enum State {WANDER, PURSUE}
var current_state := State.WANDER

var wander_target : Vector3 # global(?) position that the enemy wanders to
var pursue_target : Node3D
# states:
# wander, pursue

func _ready():
	player_detection.player_detected.connect(_on_player_detected)
	health.connect("health_depleted", _on_health_depleted)
	health.connect("health_changed", _on_health_changed)

func _physics_process(delta: float) -> void:
	if pursue_target:
		process_state_pursue(delta)

func _on_player_detected(player: Player):
	pursue_target = player


func process_state_pursue(delta: float):
	# move towards target!
	if not pursue_target:
		printerr('no pursue target!')
		return
	
	var dir = (pursue_target.position - position).normalized()
	velocity = move_speed * dir
	
	velocity += get_gravity()
	move_and_slide()

func _on_health_depleted():
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()

func _on_health_changed(value):
	#if health.health <= 0:
		#return
	if value > 0:
		return
	if animation_player and animation_player.has_animation("hurt"):
			animation_player.play("hurt")
