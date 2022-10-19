extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_parent().position.x)
	if get_parent().position.x < 0:
		#flip_h = true
		flip_v = false
	else:
		#flip_h = false
		flip_v = true
