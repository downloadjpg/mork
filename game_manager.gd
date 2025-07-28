extends Node

var player : Player = null
var player_dead : bool = false
var inventory = {}

func _ready():
	Events.player_spawn.connect(_on_player_spawn)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	inventory["key"] = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("shoot"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("shoot"):
		if player_dead:
			restart_game()

func set_player(node: Player):
	player = node
	emit_signal("player_set")

func send_message(message: String):
	var message_log = get_node("/root/Main/UI/MarginContainer/MessageLog")
	message_log.send_message(message)

func _on_player_spawn(ref):
	player = ref

func _on_player_death():
	# make player invisible
	# add a silly bouncing camera?
	# add text to restart
	
	player.visible = false
	player_dead = true

func restart_game():
	pass
