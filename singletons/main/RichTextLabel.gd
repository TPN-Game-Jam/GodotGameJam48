extends RichTextLabel


export var counter = -200

func _physics_process(delta):
	if counter < -100:
		counter += 1
	elif counter < 161:
		counter += 1
		set_bbcode("[fade start=" + str(counter) + " length=10]" + text + "[/fade]")
	else:
		set_bbcode("[fade start=" + str(counter-180) + " length=10]" + "███████████████████████████████████████████████████████████████████████████████████████████" + "[/fade]")

