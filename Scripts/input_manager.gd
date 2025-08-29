extends Control
var player
func _ready() -> void:
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
	
func _input(event):
	if event is InputEventMIDI:
		if event.channel == 0 and event.message == 9:
			
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
				
func player_moved():
	print("end")
func set_player(player_p):
	player = player_p
