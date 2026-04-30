extends CharacterBody2D


@export var health : int = 200


func take_damage(damage):
	health -= damage
	print(str(self) +"Damage: " + str(damage))
	
	
func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
