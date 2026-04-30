extends Node2D

class_name SpellScene

var user

func setup():
	pass

func next_behavior(data : SpellData, direction : Vector2 = Vector2.ZERO):
	if data.next_behavior:
		data.next_behavior.execute(user, global_position, direction, get_root_node())
		
func get_root_node() -> Node:
	return get_tree().get_root()
	

func is_enemy(body) -> bool:
	if body.has_method("take_damage") and body.is_in_group("Gegner"):
		return true
	return false


func find_node_wGroup(group : String):
	return find_child_with_group(self, group)

func find_child_with_group(node: Node, group: String):
	for child in node.get_children():
		if child.is_in_group(group):
			return child
		var deep = find_child_with_group(child, group)
		if deep:
			return deep
	return null


 
