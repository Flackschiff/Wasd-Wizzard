extends SpellBehavior

class_name Projectile_Behavior


@export var spelldata : ProjektilData

var projectile_scene: PackedScene = preload("uid://c2aytw73abbmj")


func execute(user, position, direction, world_scene):
	var proj = projectile_scene.instantiate()
	#übergibt alle daten vom Spieler 
	proj.global_position = position
	proj.direction = direction
	proj.user = user
	
	#gibt alle variablen spell eigentschaften
	proj.data = spelldata
	
	world_scene.get_tree().current_scene.add_child(proj)
