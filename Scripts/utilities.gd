extends CanvasLayer

@onready var crank := $Crank
@onready var hand := $Hand

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		for child in get_children():
			if child is Panel and child.visible:
				child.visible = false

func hide_chank():
	crank.hide()

func show_crank():
	crank.show()

func hide_hand():
	hand.hide()

func show_hand():
	hand.show()
