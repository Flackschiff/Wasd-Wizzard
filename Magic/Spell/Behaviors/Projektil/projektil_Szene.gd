extends Area2D


var direction : Vector2 = Vector2.RIGHT
var user

#alle Variablen Spelleigenschaften
var data: SpellData

func _ready() -> void:
	#ändert die größe der Hitbox und den Sprite
	var circle = CircleShape2D.new()
	circle.radius = data.projectil_radius
	$CollisionShape2D.shape = data.shape
	$Sprite2D.texture = data.projectil_sprite
	await get_tree().create_timer(data.lifetime).timeout
	next_behavoir()
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * data.speed * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		print(str(body) + "hat " + str(data.damage) +  " schaden bekommen")
		body.take_damage(data.damage)
		
		next_behavoir()
		queue_free()

func get_root_node() -> Node:
	return get_tree().get_root()

func next_behavoir():
	if data.next_behavior != null:
		data.next_behavior.execute(user,global_position,direction,get_root_node())
