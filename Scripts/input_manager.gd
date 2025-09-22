extends Control
var player
var playing
var main_menu
func _ready() -> void:
	if get_tree().current_scene.name == "Main":
		playing = true
		print("playing")
	if get_tree().current_scene.name == "MainMenu":
		main_menu = true
		print("main")
	OS.open_midi_inputs()
	
	
func _input(event):
	if event is InputEventMIDI:
		if event.channel == 0 and event.message == 9:
			if playing:
				if event.pitch == 51:
					player.go_up()
				elif event.pitch == 52:
					player.go_down()
				elif event.pitch == 66:
					player.key_pressed(0)
				elif event.pitch == 68:
					player.key_pressed(1)
				elif event.pitch == 70:
					player.key_pressed(2)
				#elif event.pitch == 63:
					#player.key_pressed(3)
			elif !playing and !main_menu:
				if event.pitch == 66:
					get_parent().play_again()
			elif main_menu:
				if event.pitch == 66:
					get_parent().get_node("Transition").dead("main.tscn")
				
func player_moved():
	pass
func set_player(player_p):
	player = player_p
