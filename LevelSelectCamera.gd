extends Camera2D


# Declare member variables here. Examples:
var target
var base_pos
var camera_zoom
#onready var diver = get_node("/root/Node/TheDiver")

func _ready():
	self.set_zoom(Vector2(3,3))

func _physics_process(_delta):
	target = get_local_mouse_position()
	if Input.is_action_just_pressed("Debug"):
		print(self.global_position.x)
	if Input.is_action_just_pressed("Look"):
		self.set_zoom(Vector2(1,1))
	
#Not how to add camera delay
	#base_pos = diver.position
	#if Input.is_action_pressed("Debug"):
	#	print(str(diver.position) + "posuition")
	#position = position.linear_interpolate(base_pos, 10*delta)
	
	#Zoom feature for camera
#	if Input.is_action_pressed("Look"):
#		position = position.linear_interpolate(Vector2(target)/4, delta*10)
#		self.zoom = self.zoom.linear_interpolate(Vector2(1.3,1.3), delta*4)
#		#self.set_zoom(Vector2(1,1).linear_interpolate(Vector2(2,2), delta*10))
#		print(self.zoom)
#	else:
#		position = position.linear_interpolate(Vector2.ZERO, delta*10)
#		self.zoom = self.zoom.linear_interpolate(Vector2(1,1), delta*4)
	camera_zoom = Vector2(get_parent().dist_to_level/200, get_parent().dist_to_level/200)
	if self.global_position.x > -1600 or camera_zoom:
		if camera_zoom.length() > Vector2(2.5,2.5).length():
			self.set_zoom(Vector2(2.5,2.5))
			get_parent().speedh = 400
			get_parent().speedy = 400
		elif Vector2(1,1).length() > camera_zoom.length():
			self.set_zoom(Vector2(1,1))
			get_parent().speedh = 160
			get_parent().speedy = 160
		else:
			self.set_zoom(camera_zoom)
			get_parent().speedh = 0.8 * get_parent().dist_to_level
			get_parent().speedy = 0.8 * get_parent().dist_to_level

#Zoom in at map edge. Tutorial is messing things up
#	else:
#		camera_zoom = Vector2(2.5-((-1600-self.global_position.x)/200),2.5-((-1600-self.global_position.x)/200))
#		if camera_zoom.length() > Vector2(2.5,2.5).length():
#			self.set_zoom(Vector2(2.5,2.5))
#			get_parent().speedh = 400
#			get_parent().speedy = 400
#		elif Vector2(1,1).length() > camera_zoom.length():
#			self.set_zoom(Vector2(1,1))
#			get_parent().speedh = 160
#			get_parent().speedy = 160
#		else:
#			self.set_zoom(camera_zoom)
#			get_parent().speedh = 0.8 * get_parent().dist_to_level
#			get_parent().speedy = 0.8 * get_parent().dist_to_level
#		print(self.zoom)
