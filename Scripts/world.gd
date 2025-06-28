extends Node2D

@onready var hand := $HandHandler/TheHand

func _ready() -> void:
	Ui.show()
	BackGround.change_color(0.1, 0.1, 0, 1)
	DialogueManager.start_dialogue("Start")
