extends Camera2D


# Declare member variables here. Examples:
var target
var base_pos

#onready var diver = get_node("/root/Node/TheDiver")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	target = get_local_mouse_position()
	
#Not how to add camera delay
	#base_pos = diver.position
	#if Input.is_action_pressed("Debug"):
	#	print(str(diver.position) + "posuition")
	#position = position.linear_interpolate(base_pos, 10*delta)
	#Zoom feature for camera
	
	
	if Input.is_action_pressed("Look"):
		position = position.linear_interpolate(Vector2(target)/4, delta*10)
		self.zoom = self.zoom.linear_interpolate(Vector2(1.3,1.3), delta*4)
		#self.set_zoom(Vector2(1,1).linear_interpolate(Vector2(2,2), delta*10))
		print(self.zoom)
	else:
		position = position.linear_interpolate(Vector2.ZERO, delta*10)
		self.zoom = self.zoom.linear_interpolate(Vector2(1,1), delta*4)
