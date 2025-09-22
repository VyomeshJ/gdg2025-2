extends AnimatedSprite2D

func _ready() -> void:
	get_tree().paused = true
	self.play("open")
	await animation_finished
	self.hide()
	get_tree().paused = false
func dead(scene_name):
	self.show()
	self.play("close")
	await animation_finished
	get_tree().change_scene_to_file("res://Scenes/"+scene_name)
