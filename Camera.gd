extends Camera2D


# Declare member variables here. Examples:
var target
#var base_pos
onready var viewport = get_viewport()
onready var miniport
#onready var diver = get_node("/root/Node/TheDiver")

func _ready():
	print(viewport)
	if get_parent().name == "MinimapDiver":
		if not Input.is_action_pressed("UIShowHide"):
			#limit_left = get_tree().get_root().get_child(1).get_node("FogStart").get_global_position().x
			#limit_top = get_tree().get_root().get_child(1).get_node("FogStart").get_global_position().y
			#limit_bottom = get_tree().get_root().get_child(1).get_node("FogEnd").get_global_position().y
			#limit_right = get_tree().get_root().get_child(1).get_node("FogEnd").get_global_position().x	
			pass
		if limit_right - limit_left < 5000:
			self.zoom = Vector2(5,5)

func _physics_process(delta):

	
#Not how to add camera delay
	#base_pos = diver.position
	#if Input.is_action_pressed("Debug"):
	#	print(str(diver.position) + "posuition")
	#position = position.linear_interpolate(base_pos, 10*delta)
	
	#Zoom feature for camera
	target = get_local_mouse_position()
	if get_parent().name != "MinimapDiver":
		if not Input.is_action_pressed("UIShowHide"):
			set_custom_viewport(viewport)
			if Input.is_action_pressed("Look"):
				position = position.linear_interpolate(Vector2(target)/4, delta*10)
				self.zoom = self.zoom.linear_interpolate(Vector2(1.3,1.3), delta*4)
				#self.set_zoom(Vector2(1,1).linear_interpolate(Vector2(2,2), delta*10))
				print(self.zoom)
			else:
				position = position.linear_interpolate(Vector2.ZERO, delta*10)
				self.zoom = self.zoom.linear_interpolate(Vector2(1,1), delta*4)
		#else:
		#	self._set_current(false)
			
#	else:
#		miniport = get_tree().get_root().get_child(1).get_node("CanvasLayer/ViewportContainer/Viewport")
#		if Input.is_action_pressed("UIShowHide"):
#			set_custom_viewport(viewport)
#			self.make_current()
#			print("View")
#		else:
#			set_custom_viewport(miniport)
