extends CanvasLayer

func _ready() -> void:
	Ui.hide()
	BackGround.change_color(0.8, 0.8, 0.8, 1)
	SoundManager.stop_ambient()
