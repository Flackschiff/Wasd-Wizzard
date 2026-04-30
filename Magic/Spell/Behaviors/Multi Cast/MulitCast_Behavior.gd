extends SpellBehavior

class_name MultiCast_Behavior

@export var behaviors: Array[SpellBehavior] = []
@export var repeat := false
@export var repeat_count := 1
@export var spread : bool = false
@export var sprey : int # Sprey in grad in beide richtung 

func execute(user, position, direction, spell_scene):
	if repeat:
		for i in range(repeat_count):

			var final_dir = direction

			if spread:
				var angle = deg_to_rad(randf_range(-sprey, sprey))
				final_dir = direction.rotated(angle)

			behaviors[0].execute(user, position, final_dir, spell_scene)

	else:
		for ferhalten in behaviors:
			ferhalten.execute(user, position, direction, spell_scene)
