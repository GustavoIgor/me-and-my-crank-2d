extends CharacterBody2D
@onready var animation = $AnimationPlayer
var game_paused = false

var speed = 70

func _ready() -> void:
	Global.game_paused.connect(_on_game_paused)
	Global.game_unpaused.connect(_on_game_unpaused)

func _process(delta: float) -> void:
	if game_paused:
		return
	var direction := Input.get_vector("left", "right","up", "down")
	
	velocity = direction * speed
	move_and_slide()
	animate_player(direction)

func animate_player(direction : Vector2):
	if direction.y > 0:
		animation.play("walk_down")
	elif direction.y < 0:
		animation.play("walk_up")
	elif direction.x > 0:
		pass
		#animation.play("walk_right")
	elif direction.x < 0:
		pass
		#animation.play("walk_left")
		
	SoundManager.play_sfx(preload("res://Assets/Songs/footsteps-male-362053.mp3"))
		
	if direction == Vector2(0,0):
		SoundManager.stop_all_sfx()
		animation.play("idle")

func _on_game_paused():
	game_paused = true

func _on_game_unpaused():
	game_paused = false
