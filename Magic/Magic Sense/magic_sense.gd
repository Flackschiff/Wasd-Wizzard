extends Node2D

class_name Magic_Sense

signal sense_aborted
signal cast_success
var player_spells #wird mit den spells von dem spierler gefüllt

var chant_lib : Dictionary
var chant_progress := {}  # spell -> index


func _ready() -> void:
	spell_setup()


func _physics_process(delta: float) -> void:
	var input_dir := get_input_direction()
	if input_dir == "":
		return  # keine Taste gedrückt

	var to_remove := []
	var to_cast = null

	for spell in chant_lib:
		var chant = chant_lib[spell]
		var index = chant_progress[spell]

		# passt die Eingabe zum aktuellen Schritt?
		if chant[index] == input_dir:
			print(chant[index])
			chant_progress[spell] += 1

			# Spell fertig?
			if chant_progress[spell] == chant.size():
				to_cast = spell
		else:
			# passt nicht → raus
			to_remove.append(spell)

	#__Spell behandlung__
	# falsche Spells entfernen
	for spell in to_remove:
		chant_lib.erase(spell)
		chant_progress.erase(spell)
		print("removes: " + spell)

	# fertige Spells casten
	if to_cast != null:
		emit_signal("cast_success", to_cast)
		emit_signal("sense_aborted")
		
	if chant_lib.size() == 0:
		emit_signal("sense_aborted") #sendet das signal dass magic sense geschlossen werden sol



func get_input_direction() -> String:
	if Input.is_action_just_pressed("UP"): return "UP"
	if Input.is_action_just_pressed("DOWN"): return "DOWN"
	if Input.is_action_just_pressed("LEFT"): return "LEFT"
	if Input.is_action_just_pressed("RIGHT"): return "RIGHT"
	return ""

func spell_setup(): #macht die chant_lib und longes_chant
	for spell in player_spells:
		var chant = []
		chant_progress[spell.name] = 0 #setzt den progress für jeden spell auf 0
		
		for direction in spell.chant:
			chant.append(direction.richtung)
		chant_lib[spell.name] = chant
		
	print(chant_lib)


func update_spells(spells: Array[Spell]):
	player_spells = spells
