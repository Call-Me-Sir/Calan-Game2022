extends Node

#onready var canvas = $CanvasModulate
var userinterface = preload("res://TrueGui.tscn")
var minidiver = preload("res://MinimapDiver.tscn")
const Light1 = preload("res://Resources/NarrowBeam.png")
const Light2 = preload("res://Resources/CircleLight.png")
var minimapscript = preload("res://Minimap.gd")
#var level = load("res://" + self.name + ".tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasModulate.color = Color(0,0,0,1)
	var inception = self.duplicate()
	
	inception.name = "StrippedMap"
	var minimapdiver = minidiver.instance()
	var gui = userinterface.instance()
	add_child(gui)
	if self.name != "StrippedMap":
		get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport").add_child(inception)
		inception.get_node("TheDiver").queue_free()
		inception.get_node("CanvasLayer").queue_free()
		inception.add_child(minimapdiver)
		var MiniObjectives = inception.get_node("Objectives").get_children()
		#get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/TheDiver").queue_free()
		#get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/CanvasLayer").queue_free()
		#get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap").add_child(minimapdiver)
		#var MiniObjectives = get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/Objectives").get_children()
		get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/CanvasModulate").color = Color(0.01,0.01,0.01,1)
		inception.get_node("CanvasModulate").color = Color(0.2,0.2,0.2,1)
		#var Objectives = get_tree().get_nodes_in_group("Objective")
		for i in MiniObjectives:
			#i.player = get_tree().get_root().get_node("Tutorial/CanvasLayer/ViewportContainer/Viewport/StrippedMap/MinimapDiver")
			i.set_script(null)
		#I'm sorry. This is the only way I can think of making the minimap script run a 'ready-esque' function when its attached to the minimap
		#inception.connect("script_changed", inception, "_on_Deep_Cave_script_changed")
		inception.set_script(minimapscript)
		inception.connect("renamed", inception, "startup")
		inception.name = "Minimap"
		print(inception.get_script())
		print(self.get_script())
#	elif self.name == "StrippedMap":
#		var fog = Sprite.new()
#		#I'm sorry
#		self.add_child_below_node(get_tree().get_root().get_node(get_tree().get_root().get_child(0).name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/Objectives"), fog)
#		fog.name = "Fog"
	else:
		print(self.name)
		print("Whassup")
# 	Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#$FogTiles.hide()
	#var canvaschange = diver.player_depth/15300 #Specific Number: 255(255 in editor = 1 in color) * 30 (Playerdepth/30 = UI depth
	#canvas.color = Color(0.65-canvaschange,0.65-canvaschange,0.65-canvaschange)
