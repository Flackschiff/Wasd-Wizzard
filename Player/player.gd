extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var spells : Array[Spell]

@onready var sense = preload("uid://be0qll04oqaue")


var sense_active = false

func _physics_process(delta):
	
	#__Movment__
	if not sense_active:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
		input_vector.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
		input_vector = input_vector.normalized()

		velocity = input_vector * movement_speed
		#__
	else:
		velocity = Vector2.ZERO
	
	#__Magic Sense__
	#timer damti man nicht man das nicht spammen kann 
	if Input.is_action_just_pressed("LinkeMaustaste"):
		activate_magic_sense()
	if Input.is_action_just_released("LinkeMaustaste"):
		deactivate_magic_sense()

	move_and_slide()


func activate_magic_sense():
	print("Maaagic onnnnnnn")
	var sense_inst = sense.instantiate()
	sense_inst.update_spells(spells)
	add_child(sense_inst)
	sense_inst.sense_aborted.connect(deactivate_magic_sense)
	sense_inst.cast_success.connect(cast_spell)
	sense_active = true

func deactivate_magic_sense():
	print("Maaaagic offffffff")
	if sense_active:
		$Magic_Sense.queue_free()
		sense_active = false
		
func cast_spell(spell_name : String):
	print("es wurde " + spell_name + " Gezaubert")
	var spell : Spell
	#es wird der richtige spell aus den spells von dem Charakter ausgesucht
	for zauber in spells:
		if zauber.name == spell_name:
			spell = zauber

	spell.behavior.execute("player",global_position, get_mouse_direction(),get_root_node())
	
func get_mouse_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()

func get_root_node() -> Node:
	return get_tree().get_root()
