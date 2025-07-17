extends Node3D

var looted = false
#var contents : Array
# contents? single node?

@onready var sprite_open = $SpriteOpen
@onready var sprite_closed = $SpriteClosed
@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.connect("interact", _on_interact)

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
