extends CanvasLayer

@onready var animation := $AnimationPlayer

func fade_transition(path : String):
	await fade_in()
	get_tree().change_scene_to_file(path)
	await fade_out()
	
func fade_in():
	show()
	animation.play("fade_in")
	await animation.animation_finished
	
func fade_out():
	animation.play("fade_out")
	await animation.animation_finished
	hide()
