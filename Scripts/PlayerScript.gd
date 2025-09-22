extends Node2D
@export var first_player = false
var current_player: bool
var in_position: bool
static var inside_x = -130
static var outside_x = -250
var top_position
var middle_position
var bottom_position
var speed
var current_pos = 0
var target_pos
var transition = false
var InputManager
var self_destroy: bool
@onready var key: Label = $Key
var player_in_area: bool
var num_key_required
var new_player
@onready var flame: AnimatedSprite2D = $Flame
var Scroller
var finished
var dead
var aud

func _ready() -> void:
	aud = get_parent().get_node("AudioStreamPlayer")
	Scroller = get_parent().get_node("Map")
	top_position = Vector2(inside_x, -60)
	middle_position = Vector2(inside_x, 0)
	bottom_position = Vector2(inside_x, 60)
	if first_player:
		current_player = true
		target_pos = middle_position
		InputManager = get_parent().get_node("InputManager")
		InputManager.set_player(self)
		flame.show()
		
func _process(delta: float) -> void:
	if Scroller != null and current_player and !finished: speed = 300
	elif Scroller != null and !current_player and !finished: speed = Scroller.speed/1.5
	position = position.move_toward(target_pos, delta*speed)
	if position == target_pos:
		if self_destroy:
			queue_free()
		transition = false
	if position.x < -200 and !dead and !current_player:
		dead = true
		aud.hurt()
		Scroller.Dead()

	#position = move_toward(target_pos, delta)

func go_up():
	if !transition:
		transition = true
		if current_pos == 0:
			current_pos += 1
			target_pos = top_position
		elif current_pos == -1:
			current_pos += 1
			target_pos = middle_position
	
func go_down():
	if !transition:
		transition = true
		if current_pos == 1:
			current_pos -= 1
			target_pos = middle_position
		elif current_pos == 0:
			current_pos -= 1
			target_pos = bottom_position
	
func show_key():
	var choices = ["1", "2", "3"]
	num_key_required = randi() % 3
	new_player.key.text = choices[num_key_required]

func hide_key():
	key.text = ""

func key_pressed(key_pressed):
	
	if num_key_required != key_pressed and new_player != null:
		new_player.key.text = ""
		new_player = null
		if !dead:
			dead = true
			aud.hurt()
			Scroller.Dead()
	elif new_player != null:
		
		if player_in_area and new_player.position.x > self.position.x:
			aud.pickup()
			new_player.key.text = ""
			new_player.flame.show()
			flame.hide()
			new_player.target_pos = Vector2(inside_x, new_player.target_pos.y)
			InputManager.set_player(new_player)
			new_player.InputManager = InputManager
			transition = true
			target_pos=Vector2(outside_x, position.y)
			finished = true
			speed = Scroller.speed/1.2
			self_destroy = true
			#new_player.speed = 300
			new_player.current_player = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	#if current_player: print(area.get_parent().name.substr(0,6))
	if current_player and area.get_parent().name.substr(0,6) == "Player" and area.get_parent().position.x > position.x:
		player_in_area = true
		#show_key()
		new_player = area.get_parent()
		show_key()
		#new_player.target_pos = Vector2(inside_x, new_player.target_pos.y)
		#InputManager.set_player(new_player)
		#new_player.InputManager = InputManager
		#transition = true
		#target_pos=Vector2(outside_x, position.y)
		#self_destroy = true
		#new_player.speed = 300
		#new_player.current_player = true
	


func _on_area_2d_area_exited(area: Area2D) -> void:
	if new_player == area.get_parent():
		new_player = null
		print("gone")
		player_in_area = false
		area.get_parent().hide_key()
		hide_key()
	pass # Replace with function body.
