extends CanvasLayer

func _ready() -> void:
	BackGround.change_color(0, 0, 0, 1)

func _on_play_pressed() -> void:
	Fade.fade_transition("res://Scenes/world.tscn")


func _on_credits_pressed() -> void:
	Fade.fade_transition("res://Scenes/credits.tscn")
