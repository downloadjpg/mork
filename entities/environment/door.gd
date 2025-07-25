extends Node3D


@onready var interaction_area = $InteractionArea

var is_open = false
var locked = true

@onready var open_sprite = $SpriteOpen
@onready var closed_sprite = $SpriteClosed
@onready var locked_sound = $LockedSound
@onready var open_sound = $OpenSound
@onready var close_sound = $CloseSound

func _ready() -> void:
	interaction_area.connect("interact", _on_interact)

func _on_interact():
	if is_open:
		close()
		return
	# closed
	if locked:
		if GameManager.inventory["key"] >= 1:
			GameManager.send_message("You use your key to open the door.")
			GameManager.inventory["key"] -= 1
			open()
		else:
			locked_sound.play()
			GameManager.send_message("The door rattles. Locked!")
			
	else:
		open()

func open():
	is_open = true
	locked = false
	$StaticBody3D/CollisionShape3D.disabled = true
	open_sprite.visible = true
	closed_sprite.visible = false
	open_sound.play()

func close():
	is_open = false
	$StaticBody3D/CollisionShape3D.disabled = false
	open_sprite.visible = false
	closed_sprite.visible = true
	close_sound.play()
