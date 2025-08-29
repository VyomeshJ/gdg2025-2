extends TileMap




func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	var new_tile = self.duplicate()
	new_tile.position.x = position.x + 448
	get_parent().add_child(new_tile)
	pass # Replace with function body.


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	self.queue_free()
	pass # Replace with function body.
