extends Control

@export var next_scene : PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var game = next_scene.instantiate()
		get_tree().root.add_child(game)
		queue_free()
