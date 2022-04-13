extends Area2D


# Declare member variables here. Examples:
var vardone = 1 
onready var polygon = $Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if vardone == 2:
		self.add_to_group("Complete")
	if Input.is_action_just_pressed("Debug"):
		print(polygon.color.get_pixel(0,0))


func _on_Pipe_area_entered(area):
	if area.name == "Hand":
		if Input.is_action_pressed("Tool") and vardone == 1:
			vardone = 2
			polygon.color = Color(1,0,0)
