extends Node2D
var positions = [Vector2(-250, 60), Vector2(-250, 0), Vector2(-250, -60)]
const PLAYER = preload("res://Objects/player.tscn")
@onready var timer: Timer = $Timer

func _instantiate():
	var num = randi() % 3
	var new_player = PLAYER.instantiate()
	new_player.name = "Player"
	new_player.position = Vector2(position.x, positions[num].y)
	new_player.target_pos = positions[num]
	#new_player.speed = new_player.speed/6
	new_player.current_pos = num-1
	get_parent().add_child(new_player, true)
	new_player.position = Vector2(position.x, positions[num].y)
	
func _on_timer_timeout() -> void:
	_instantiate()


func _on_start_timer_timeout() -> void:
	_instantiate()
	timer.start()
	pass # Replace with function body.


func _on_reduce_delay_timeout() -> void:
	if timer.wait_time > 1.5:
		timer.wait_time -= 0.25
		
