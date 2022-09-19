extends ViewportContainer


# Declare member variables here. Examples:
onready var viewport = get_node("Viewport")
onready var initialx = get_tree().get_root().size.x
onready var initialy = get_tree().get_root().size.y
var startposition
var startsize
var ViewSize

# Called when the node enters the scene tree for the first time.
func _ready():
	startposition = rect_position
	startsize = rect_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	initialx = get_tree().get_root().size.x
	initialy = get_tree().get_root().size.y
	#print(initialx)
	ViewSize = Vector2(initialx,initialy)
	if Input.is_action_pressed("UIShowHide"):
		rect_position = Vector2(0,0)
		rect_size = ViewSize
		viewport.set_size(ViewSize)
	else:
		rect_position = startposition
		rect_size = startsize
		viewport.set_size(startsize)
