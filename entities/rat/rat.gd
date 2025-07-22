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
# states:
# wander, pursue

func _ready():
	player_detection.player_detected.connect(_on_player_detected)
	health.connect("health_depleted", _on_health_depleted)
	health.connect("health_changed", _on_health_changed)

func _physics_process(delta: float) -> void:
	state_process(delta)

func _on_player_detected(player: Player):
	print('gabba goo!')

func state_enter():
	match current_state:
		State.WANDER:
			enter_state_wander()
		State.PURSUE:
			enter_state_pursue()

func state_exit():
	match current_state:
		State.WANDER:
			exit_state_wander()
		State.PURSUE:
			exit_state_pursue()

func state_process(delta: float):
	match current_state:
		State.WANDER:
			process_state_wander(delta)
		State.PURSUE:
			process_state_pursue(delta)


func enter_state_wander():
	pass

func process_state_wander(delta: float):
	# if our timer has expired, pick a new position
	if not wander_target or new_wander_target_timer.time_left == 0:
		print('new loc')
		# select a new wander position, start the timer
		var direction = Vector3(randf(), 0, randf())
		var length = randf_range(1, 5)
		wander_target = position + direction * length
		new_wander_target_timer.start()
	# move towards our target position
	var dir = (wander_target - position).normalized()
	velocity = move_speed * dir
	move_and_slide()
	

func exit_state_wander():
	pass


func enter_state_pursue():
	pass

func process_state_pursue(delta: float):
	pass

func exit_state_pursue():
	pass


func _on_health_depleted():
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()

func _on_health_changed(value):
	if health.health <= 0:
		return
	if value > 0:
		return
	if animation_player and animation_player.has_animation("hurt"):
			animation_player.play("hurt")
