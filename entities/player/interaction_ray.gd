extends RayCast3D
class_name InteractionRay

var current_focus = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var collider = get_collider()
	if collider == null:
		unfocus(current_focus)
		return
	focus(collider)
	if Input.is_action_just_pressed("interact"):
		interact(current_focus)

func focus(object):
	if current_focus == object:
		return
	current_focus = object
	if current_focus.has_signal("focus"):
		current_focus.emit_signal("focus")

func unfocus(object):
	if current_focus == null:
		return
	if object.has_signal("unfocus"):
		object.emit_signal("unfocus")
	current_focus = null

func interact(object):
	if object.has_signal("interact"):
		object.emit_signal("interact")
