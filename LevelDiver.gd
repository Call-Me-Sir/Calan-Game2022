extends KinematicBody2D



export var acceleration = 0.03
var velocity = Vector2.ZERO
var friction = 0.12
var speedh = 100
var speedy = 100
var gravity = 0.3
var bouyancy = 0.2
var float_speed = 20
var target
var light_delay = 6
onready var flashlight = $Light2D
onready var vision = $Light2D2
onready var person = $Polygon2D
onready var camera = $Camera2D
onready var hand = $Hand
onready var speedvector = $Speed
onready var Levels = get_tree().get_nodes_in_group("Level")
onready var Canvas = get_node("../CanvasLayer")
var popuptext = preload("res://PlayLevelTextPopup.tscn")
var widebeam = preload("res://Resources/LightMask.png")
var narrowbeam = preload("res://Resources/NarrowBeam.png")
var player_depth
var dist_to_level
var levelplay = false
var level

#var bearing = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func misc(delta):
	#Mouse makes light point
	target = get_local_mouse_position()
	var direction = Vector2(get_global_mouse_position() - self.position).normalized()*15
	var angle = get_local_mouse_position().angle()
	flashlight.rotation = lerp_angle(flashlight.rotation, angle+deg2rad(45), delta*light_delay)
	flashlight.position = flashlight.position.linear_interpolate(direction, delta*light_delay)
	hand.position = Vector2(0,0)#flashlight.position
	
	
	if get_local_mouse_position().x<0:
		person.scale.x = -1
		person.rotation = (angle+deg2rad(90))*0.3
	else:
		person.scale.x = 1
		person.rotation = (angle+deg2rad(90))*0.3
	#Zoom feature for camera
	#print(person.rotation)
	if Input.is_action_pressed("Look"):
		flashlight.texture = narrowbeam
		flashlight.texture_scale = 0.8
	else:
		flashlight.texture = widebeam
		flashlight.texture_scale = 0.5
func speed(_delta):
	pass

func levelscale(_delta):
	#Code for finding closest level
	var closest_level = Levels[0]
	for i in Levels.size():
		var closest_dist = to_local(closest_level.position)
		var competitor_dist = to_local(Levels[i].position)
		if closest_dist.length() > competitor_dist.length():
			closest_level = Levels[i]
	#Raycast to closest level for viewing purposes
	$RayCast2D.set_cast_to(to_local(closest_level.position))
	#For use in camera node script for zoom/speed purposes
	dist_to_level = to_local(closest_level.position).length()
	if Input.is_action_just_pressed("Debug"):
		print(to_local(closest_level.position).length())
func _physics_process(delta):
	#Miscellaneous Player stuff
	misc(delta)
	
	player_depth = self.position.y
	vision.energy = 1.3-(player_depth/5000)
	vision.texture_scale = 0.5-(player_depth/10000)
	flashlight.energy = 1.4-(player_depth/6000)
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	input_velocity.x = (Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"))*speedh
	input_velocity.y = (Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up"))*speedy
	
	speed(delta)
	if Input.is_action_pressed("SpeedSide"):
		#speedh = 200
		#speedy = 40
		pass
		#Rapid testing
		#speedh=600
		#speedy=600
	#elif Input.is_action_pressed("SpeedUp"):
		#speedh=60
		#speedy=150
	else:
		pass
		#speedh = 100
		#speedy = 100
		input_velocity = input_velocity.normalized() * speedh
	#input_velocity = input_velocity.normalized() * speedh
	if (Input.is_action_pressed("Tool") or Input.is_action_pressed("Tool1")) and levelplay == true:
		pass
		#get_tree().change_scene("res://" + level + ".tscn")
	#For viewing level direction
	levelscale(delta)
	speedvector.set_cast_to(input_velocity)
	
	#Float movement is meant to sink the diver slowly over time depending on how heavy they are.
	var float_movement = Vector2.ZERO
	float_movement.x=0
	float_movement.y = gravity-bouyancy
	float_movement = float_movement * float_speed
	if player_depth <= 0:
		float_movement = float_movement.normalized()*300
		
	var total_velocity = input_velocity + float_movement
	#Movement code
	if input_velocity.length() > 0 and not levelplay:
		velocity = velocity.linear_interpolate(total_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2(0,0), friction)
	velocity = move_and_slide(velocity)


func _on_Hand_area_entered(area):
	if area.is_in_group("Level"):
		print(area.name)
		#get_tree().change_scene("res://" + str(area.name) + ".tscn")
		levelplay = true
		level = str(area.name)
		var popup = popuptext.instance()
		popup.areaname = area.name
		Canvas.add_child(popup)
		
		#print("Objective")

		#area.vardone = true


func _on_Hand_area_exited(area):
	if area.is_in_group("Level"):
		levelplay = false
		level = null
		print("yeeee")
		#print("Objective Left")
