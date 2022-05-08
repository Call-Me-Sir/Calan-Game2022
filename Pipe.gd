extends Area2D


# Declare member variables here. Examples:
var vardone = 1 
onready var polygon = $Polygon2D
onready var label = $Label
onready var timer = $Timer
onready var sparks = $Particles2D
onready var player = get_parent().get_parent().get_node("TheDiver")
var hand = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = self.name
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vardone == 2:
		self.add_to_group("Complete")
	if Input.is_action_just_pressed("Debug"):
		#print(player.position)
		print(label.get_position())
		#print(polygon.color.get_pixel(0,0))
		print(timer.is_stopped())
	$RayCast2D.set_cast_to(-to_local(player.position).normalized()*40)
	label.set_position($RayCast2D.cast_to)
	label.set_position(label.get_position() - Vector2(18,6))
	if Input.is_action_pressed("Tool") and vardone == 1 and hand == true and timer.is_stopped() == false:
		sparks.set_emitting(true)
		timer.start()
		if Input.is_action_just_released("Tool") or hand == false:
			sparks.set_emitting(false)
			timer.set_paused(true)
			timer.start()
	elif Input.is_action_pressed("Tool") and vardone == 1 and hand == true and timer.is_stopped():
		sparks.set_emitting(true)
		timer.set_paused(false)
		if Input.is_action_just_released("Tool") or hand == false:
			sparks.set_emitting(false)
			timer.set_paused(true)
			timer.start()


func _on_Pipe_area_entered(area):
	if area.name == "Hand":
		hand = true


func _on_Pipe_area_exited(area):
	if area.name == "Hand":
		hand = false


func _on_Timer_timeout():
	vardone = 2
	polygon.color = Color(1,0,0)
