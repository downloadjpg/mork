extends TextureRect

var player : Player
@export var effect_duration = 0.2


func _process(delta: float) -> void:
	# TODO: refactor this so it isn't called every frame
	if player == null:
		player = GameManager.player
		if player:
			player.health.health_changed.connect(_on_player_health_changed)
		return


# TODO: this sucks... create a health_lowered signal?
func _on_player_health_changed(delta):
	if delta < 0:
		visible = true
		await get_tree().create_timer(effect_duration).timeout
		visible = false
