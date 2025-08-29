extends Node2D
var positions = [Vector2(-250, 60), Vector2(-250, 0), Vector2(-250, -60)]
const PLAYER = preload("res://Objects/player.tscn")
func _ready():
	pass

func _on_timer_timeout() -> void:
	var num = randi() % 3
	var new_player = PLAYER.instantiate()
	new_player.name = "Player"
	new_player.position = Vector2(position.x, positions[num].y)
	new_player.target_pos = positions[num]
	new_player.speed = 50
	new_player.current_pos = num-1
	get_parent().add_child(new_player, true)
	
	pass # Replace with function body.
