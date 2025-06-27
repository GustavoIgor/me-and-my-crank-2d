extends Panel

var current_door: Node = null

@onready var label := $VBoxContainer/Label
@onready var feedback := $VBoxContainer/FeedBackLabel

func set_door(door):
	current_door = door
	label.text = "Cost:\nMinerals: %d\nCrystals: %d\nInfuseds: %d" % [door.required_minerals, door.required_crystals, door.required_infuseds]
	feedback.text = ""

func _on_open_pressed() -> void:
	if current_door:
		if current_door.try_open():
			visible = false
		else:
			feedback.text = "Not enought resourses."
