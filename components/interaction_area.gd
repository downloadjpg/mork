extends Area3D
class_name InteractionArea


@export var modulate_targets : Array[Sprite3D]
@export var hover_modulate := Color("beaaaa")

signal interact
signal focus
signal unfocus

func _ready():
	focus.connect(_on_focus)
	unfocus.connect(_on_unfocus)

func _on_focus():
	for sprite in modulate_targets:
		sprite.modulate = hover_modulate

func _on_unfocus():
	for sprite in modulate_targets:
		sprite.modulate = Color.WHITE
