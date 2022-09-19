tool
extends Polygon2D

export(Color) var OutLine = Color(0,0,0) setget set_color
export(float) var Width = 2.0 setget set_width
var fragmentscript = preload("res://FragmentScript.gd")

func _draw():
	var poly = get_polygon()
	var newpoly = poly.push_back(poly[0])
	draw_polyline(poly, OutLine, Width)

	#draw_line(poly[0],poly[poly.size()-1], OutLine, Width)
	#for i in range(1 , poly.size()):
	#	draw_line(poly[i-1] , poly[i], OutLine , Width)
	#draw_line(poly[poly.size() - 1] , poly[0], OutLine , Width)
	print(poly)

func set_color(color):
	OutLine = color
	update()

func set_width(new_width):
	Width = new_width
	update()
	

	
func fragment():
	if not Engine.editor_hint:
		get_parent().intact = false
		var points = polygon
		var delaunary_points = Geometry.triangulate_delaunay_2d(points)
		var shardpool = PoolVector2Array()
		for index in len(delaunary_points)/3:
			for n in range(3):
				shardpool.append(points[delaunary_points[(index*3)+n]])
			var shard = RigidBody2D.new()
#			var shardest = Polygon2D.new()
#			var shardcol = CollisionPolygon2D.new()
#			shard.add_child(shardest)
#			shard.add_child(shardcol)
#			shardest.polygon = shardpool
#			shardcol.polygon = shardpool
			get_parent().get_parent().add_child(shard)
			shard.name = "Shard"+str(index)
			get_parent().get_parent().get_node("Shard"+str(index)).set_script(fragmentscript)
			print(get_parent().get_parent().get_node("Shard"+str(index)).get_script())
			shard.polygon = shardpool
			print("fragment " + str(index))
		#get_node("Polygon2D").queue_free()
		#get_node("CollisionPolygon2D").queue_free()
		get_parent().queue_free()
