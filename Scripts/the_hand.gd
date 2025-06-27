extends Sprite2D

@onready var ani := $AnimationPlayer

func _ready() -> void:
	Global.play_hand.connect(_on_play_hand)

func working():
	SoundManager.play_sfx(preload("res://Assets/Songs/steampunk-mechanical-gadget-188052.mp3"), -20)
	ani.play("working")

func _on_play_hand():
	working()
