extends CanvasLayer

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		for child in get_children():
			if child is Panel and child.visible:
				child.visible = false
