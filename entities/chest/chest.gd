extends Node3D

var looted = false
#var contents : Array
# contents? single node?

@onready var sprite_open = $SpriteOpen
@onready var sprite_closed = $SpriteClosed
@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.connect("interact", _on_interact)
	interaction_area.connect("focus", _on_focus)
	interaction_area.connect("unfocus", _on_unfocus)

func _process(delta):
	#sprite_closed.modulate = Color.WHITE
	pass
	
func open():
	if looted:
		return
	sprite_closed.visible = false
	sprite_open.visible = true
	GameManager.send_message("you got a key!")
	GameManager.inventory["key"] += 1
	looted = true


# Base 'interact' function that the player's raycast can call
func _on_interact():
	open()

func _on_focus():
	sprite_closed.modulate = Color.RED

func _on_unfocus():
	sprite_closed.modulate = Color.WHITE
