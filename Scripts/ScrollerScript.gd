extends Node2D
var PLAYER
var speed = 150
var score = 0
@onready var score_txt: Label = $"../Score"
@onready var dead_delay: Timer = $DeadDelay
@onready var transition: AnimatedSprite2D = $"../Transition"

func _ready() -> void:
	PLAYER = get_parent().get_node("Player")
	
func _physics_process(delta: float) -> void:
	position.x -= speed * delta


func _on_timer_timeout() -> void:
	if speed < 300:
		speed += 1
	pass # Replace with function body.


func _on_score_timer_timeout() -> void:
	score += 1
	score_txt.text = str(score) + "s"
	pass # Replace with function body.
func Dead():
	ScoreHighscore.Score = score
	if ScoreHighscore.Highscore != null:
		if ScoreHighscore.Highscore < score:
			ScoreHighscore.Highscore = score
	else:	
		ScoreHighscore.Highscore = score
	
	get_tree().paused = true
	dead_delay.start()
	await dead_delay.timeout
	transition.dead("death_scene.tscn")
	
