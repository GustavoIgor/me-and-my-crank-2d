extends Node

@onready var sfx := $SFX
@onready var sfx2 := $SFX2
@onready var music := $Music

var current_music : AudioStream = null

func play_sfx(sound: AudioStream):
	if !sfx.playing:
		sfx.stream = sound
		sfx.play()
	elif !sfx2.playing:
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
