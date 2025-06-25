extends Sprite2D

@onready var ani := $AnimationPlayer

func working():
	ani.play("working")
