extends Node

var player : Player = null
var player_dead : bool = false
var inventory = {}


class PlayerVariables:
	var keys_held : int = 0
	var weapons_held : Array[Weapon]
	var health : int

var current_scene
var game_scene : PackedScene = preload("res://main.tscn")

func _ready():
	Events.game.player_spawn.connect(_on_player_spawn)
	Events.game.player_death.connect(restart_game)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	inventory["key"] = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("shoot"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
func send_message(msg: String):
	Events.ui.send_message.emit(msg)

func set_player(node: Player):
	player = node
	emit_signal("player_set")

func _on_player_spawn(ref):
	player = ref


func restart_game():
	current_scene.queue_free()
	var main = game_scene.instantiate()
	get_parent().add_child(main)
	current_scene = main
	

func change_scene(scene: PackedScene):
	if current_scene:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	get_parent().add_child(current_scene)
