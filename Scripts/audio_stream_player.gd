extends AudioStreamPlayer2D
const HIT_HURT = preload("res://audios/hitHurt.wav")
const PICKUP_COIN = preload("res://audios/pickupCoin.wav")
func _ready() -> void:
	Themeplayer.stream_paused = false
func hurt():
	self.stream = HIT_HURT
	Themeplayer.stream_paused = true
	self.play()
func pickup():
	self.stream = PICKUP_COIN
	self.play()
	
