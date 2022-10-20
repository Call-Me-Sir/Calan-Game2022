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
var light_delay = 3
onready var flashlight = $Light2D
onready var vision = $Light2D2
onready var person = $CollisionPolygon2D
onready var camera = $Camera2D
onready var hand = $Hand
onready var LevelObjectives = get_parent().get_node("Objectives")
var GUI
var widebeam = preload("res://Resources/LightMask.png")
var narrowbeam = preload("res://Resources/NarrowBeam.png")
var player_depth = 1
var Foggo_War
var Fog_Clear = false
var playerweight = 8 #For object collisions
#var bearing = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Foggo_War = $"../FogOfWar"
	$Timer.start()

func misc(delta):
	
	target = get_local_mouse_position()
	var direction = Vector2(get_global_mouse_position() - self.position).normalized()*30
	var angle = get_local_mouse_position().angle()
	flashlight.rotation = lerp_angle(flashlight.rotation, angle+deg2rad(45), delta*light_delay)
	flashlight.position = flashlight.position.linear_interpolate(direction, delta*light_delay)
	hand.position = flashlight.position
	hand.rotation_degrees = flashlight.rotation_degrees - 135 - 90
	if get_local_mouse_position().x<0:
		person.scale.x = 1
		if get_local_mouse_position().y<-50:
			person.rotation_degrees = 35
		else:
			person.rotation_degrees = 0
		#person.rotation = (angle+deg2rad(90))*0.3
	else:
		person.scale.x = -1
		if get_local_mouse_position().y<-50:
			person.rotation_degrees = -35
		else:
			person.rotation_degrees = 0
	#Zoom feature for camera
	#print(person.rotation)
	if Input.is_action_pressed("Look"):
		
		flashlight.texture = narrowbeam
		flashlight.texture_scale = 0.8
		
	else:
		flashlight.texture = widebeam
		flashlight.texture_scale = 0.5
func speed():
	pass
func hand(delta):
	if Input.is_action_pressed("Tool"):
		$Hand/Sprite.hide()
		flashlight.hide()
		$Hand/AnimatedSprite.show()
	elif Input.is_action_just_released("Tool"):
		$Hand/Sprite.show()
		flashlight.show()
		$Hand/AnimatedSprite.hide()
func _physics_process(delta):
	#if Fog_Clear == true:
		#Foggo_War.set_clear_position(global_position)
	#Miscellaneous Player stuff
	misc(delta)
	hand(delta)
	player_depth = self.position.y
	vision.energy = 1.3-(player_depth/10000)
	vision.texture_scale = 0.6-(player_depth/15000)
	flashlight.energy = 1.4-(player_depth/6000)
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	input_velocity.x = (Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"))*speedh
	input_velocity.y = (Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up"))*speedy
	if Input.is_action_pressed("SpeedSide"):
		#speedh = 200
		#speedy = 40
		
		#Rapid testing
		speedh=600
		speedy=600
	#elif Input.is_action_pressed("SpeedUp"):
		#speedh=60
		#speedy=150
	else:
		speedh = 100
		speedy = 100
		input_velocity = input_velocity.normalized() * speedh
	#input_velocity = input_velocity.normalized() * speedh
	
	#For viewing movement
	$RayCast2D.set_cast_to(input_velocity)
	
	#Float movement is meant to sink the diver slowly over time depending on how heavy they are.
	var float_movement = Vector2.ZERO
	float_movement.x=0
	float_movement.y = gravity-bouyancy
	float_movement = float_movement * float_speed
	if player_depth <= 0:
		float_movement = float_movement.normalized()*300
		
	var total_velocity = input_velocity + float_movement
	#Movement code
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(total_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(float_movement, friction)
	velocity = move_and_slide(velocity, Vector2.UP, true, 4, PI/4,false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var momentum = velocity*playerweight
		if collision.collider.is_in_group("Physics"):
			collision.collider.apply_central_impulse(-collision.normal *momentum.length() * 0.1 + input_velocity.normalized())
			var relative_velocity = collision.collider_velocity - velocity
			GUI.damage = GUI.damage + relative_velocity.length_squared()
		if collision.get_collider().name == "TileMap" and velocity.length() >= 80:
			GUI.damage += 1
			print(str(GUI.damage)+"Damage recieved")
		var collisionspeed = collision.get_collider_velocity()
		#GUI.damage += 1
		


func _on_Hand_area_entered(area):
	if area.name == "LeaveArea":
		get_tree().change_scene("res://LevelSelect.tscn")
		#print("Objective")
	if Input.is_action_pressed("Tool"):
		pass
		#area.vardone = true


func _on_Hand_area_exited(area):
	if area.is_in_group("Objective"):
		pass
		#print("Objective Left")


func _on_Timer_timeout():
	Fog_Clear = true
	print("TIME!")
	GUI = get_parent().get_node("CanvasLayer/GUI")
