extends CanvasLayer

@onready var crank := $Crank
@onready var hand := $Hand
@onready var door_panel := $DoorPanel

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Global.game_unpaused.emit()
		for child in get_children():
			if child is Panel and child.visible:
				child.visible = false

func hide_chank():
	crank.hide()

func show_crank():
	Global.game_paused.emit()
	crank.show()

func hide_hand():
	hand.hide()

func show_hand():
	Global.game_paused.emit()
	hand.show()

func hide_door_panel():
	door_panel.hide()

func show_door_panel():
	Global.game_paused.emit()
	door_panel.show()

func set_door(door):
	door_panel.set_door(door)
