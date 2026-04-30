extends SpellScene

var data : ProjektilData
var direction : Vector2 = Vector2.RIGHT

func _ready() -> void:
	setup()
	start_liftime_timer()
	print("Spell wurde Instanziert")
	
	
func _physics_process(delta: float) -> void:
	position += direction * data.speed * delta
	
func setup():
	var visual = find_node_wGroup("Spell_Visual")
	var hitbox = find_node_wGroup("Spell_Hitbox")
	
	hitbox.shape = data.shape
	visual.texture = data.projectil_sprite
		
func start_liftime_timer():
	await get_tree().create_timer(data.lifetime).timeout
	next_behavior(data,direction)
	queue_free()
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_enemy(body):
		body.take_damage(data.damage)
		next_behavior(data)
		queue_free()
