extends Area3D
class_name PlayerDetection

signal player_detected(player: Player)
signal player_lost


func _ready():
	body_exited.connect(_on_body_exited)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	var player := body as Player
	if not player:
		#printerr("Something other than a player detected by PlayerDetection")
		return
	emit_signal("player_detected", player)

func _on_body_exited(body):
	var player := body as Player
	if not player:
		#printerr("Something other than a player detected by PlayerDetection")
		return
	emit_signal("player_lost")
