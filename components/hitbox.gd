class_name HitBox
extends Area3D

@export var damage_source: Node3D = null:
	get:
		# If damage_source is explicitly set, return it
		if damage_source != null:
			return damage_source
			
		# Otherwise, check if our parent has an owner_entity property
		var current_node = get_parent()
		while current_node != null:
			if current_node.get("damage_source") != null:
				return current_node.damage_source
			current_node = current_node.get_parent()
		
		# If no owner found in chain, return null
		return null
@export var damage: int = 1
@export var knockback_force: float = 0.0
