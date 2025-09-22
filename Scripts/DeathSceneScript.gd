extends Node2D
@onready var score: Label = $Score
@onready var highscore: Label = $Highscore
@onready var transition: AnimatedSprite2D = $Transition

func _ready() -> void:
	score.text = "Score: " + str(ScoreHighscore.Score)
	highscore.text = "Highscore: " + str(ScoreHighscore.Highscore)
func play_again():
	print("play again")
	transition.dead("main.tscn")
