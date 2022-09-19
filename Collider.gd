tool
extends RigidBody2D


onready var polygon2d = get_node("Polygon2D")
onready var collidergon = get_node("CollisionPolygon2D")
var polyshape
var intact = true
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if intact == true:
		polyshape = polygon2d.get_polygon()
		collidergon.set_polygon(polyshape)
