extends Node

signal player_set
var player : Player = null

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("shoot"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func set_player(node: Player):
	player = node
	emit_signal("player_set")

func send_message(message: String):
	var message_log = get_node("/root/Main/UI/MessageLog")
	message_log.send_message(message)
