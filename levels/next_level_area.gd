extends Area3D


@export var next_scene : PackedScene

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	GameManager.change_scene(next_scene)
