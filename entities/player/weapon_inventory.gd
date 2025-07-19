extends Node3D
class_name WeaponInventory

var held_weapon : Weapon :
	set(value):
		# this fails if held weapon is set to something that isn't a child. don't know how to check for that
		held_weapon = value
		held_weapon_idx = value.get_index()
	get:
		return get_child(held_weapon_idx)
var held_weapon_idx = 0 :
	set(value):
		if get_child_count() == 0:
			return
		held_weapon.visible = false
		held_weapon_idx = value % get_child_count()
		held_weapon.visible = true

func add_to_inventory(weapon_scene : PackedScene):
	var weapon = weapon_scene.instantiate()
	add_child(weapon)



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and held_weapon:
		held_weapon.fire_weapon(-global_basis.z)
	
	if event.is_action_pressed("weapon_scroll_up"):
		held_weapon_idx += 1
	
	if event.is_action_pressed("weapon_scroll_down"):
		held_weapon_idx -= 1
