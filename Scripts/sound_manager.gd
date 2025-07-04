extends Node

@onready var sfx := $SFX
@onready var sfx2 := $SFX2
@onready var music := $Music
@onready var footsteps := $FootSteps
@onready var ambient := $Ambient

var current_music : AudioStream = null

func _ready() -> void:
	ambient.stream = load("res://Assets/Songs/room-with-buzz-incandescent-light-bulb-23892.mp3")

func play_foot_steps(sound: AudioStream):
	if !footsteps.playing:
		footsteps.stream = sound
		footsteps.play()

func stop_foot_steps():
	footsteps.stop()

func play_sfx(sound: AudioStream, volume: int = 0):
	if !sfx.playing:
		sfx.volume_db = volume
		sfx.stream = sound
		sfx.play()
	elif !sfx2.playing:
		sfx2.volume_db = volume
		sfx2.stream = sound
		sfx2.play()
	else:
		# Ambos estão ocupados, opcional: ignorar ou parar um deles
		sfx.stop()
		sfx.stream = sound
		sfx.play()

func play_music(music_stream: AudioStream, force_restart := false):
	if current_music == music_stream and !force_restart:
		return  # já está tocando
	current_music = music_stream
	music.stop()
	music.stream = music_stream
	music.play()

func stop_music():
	music.stop()
	current_music = null

func stop_all_sfx():
	sfx.stop()
	sfx2.stop()

func play_ambient():
	ambient.play()

func stop_ambient():
	ambient.stop()
