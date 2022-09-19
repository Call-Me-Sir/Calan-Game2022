extends Node

var polygon
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var shardest = Polygon2D.new()
	shardest.polygon = polygon
	var shardcol = CollisionPolygon2D.new()
	shardcol.polygon = polygon
	add_child(shardest)
	add_child(shardcol)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
