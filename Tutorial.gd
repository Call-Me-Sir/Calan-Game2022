extends Node

onready var canvas = $CanvasModulate
var userinterface = preload("res://TrueGui.tscn")
var minidiver = preload("res://MinimapDiver.tscn")
var Fog_Of_War = preload("res://FogOfWar.tscn")
const Light1 = preload("res://Resources/NarrowBeam.png")
const Light2 = preload("res://Resources/CircleLight.png")
var minimapscript = preload("res://Minimap.gd")
var MiniObjectives
var node_FOW
var FogStart
var FogEnd
var fogx
var fogy
var done = 0
var GUI
signal objectivescomplete
#var level = load("res://" + self.name + ".tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#FogCode
		#node_FOW = $"FogOfWar"
	#Set color of fog
		#node_FOW.set_fog_color(Color(0.0, 0.0, 0.0, 1.0))
		#FogStart = get_node("FogStart")
		#FogEnd = get_node("FogEnd")
		#fogx = (FogEnd.get_position().x - FogStart.get_position().x)
		#fogy = FogEnd.get_position().y - FogStart.get_position().y
		#var extent = Vector2(fogx, fogy)
		#node_FOW.level_start(extent, FogStart.position, Vector2(0.2,0.2))
	
	$CanvasModulate.color = Color(0,0,0,1)
	var inception = self.duplicate()
	
	inception.name = "StrippedMap"
	var minimapdiver = minidiver.instance()
	var gui = userinterface.instance()
	var FOW = Fog_Of_War.instance()
	add_child(gui)
	if self.name != "StrippedMap":
		get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport").add_child(inception)
		inception.get_node("TheDiver").queue_free()
		inception.get_node("CanvasLayer").queue_free()
		inception.add_child(minimapdiver)
		inception.add_child(FOW)
		MiniObjectives = inception.get_node("Objectives").get_children()
		#get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/TheDiver").queue_free()
		#get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/CanvasLayer").queue_free()
		#get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap").add_child(minimapdiver)
		#var MiniObjectives = get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/Objectives").get_children()
		get_tree().get_root().get_node(self.name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/CanvasModulate").color = Color(0.01,0.01,0.01,1)
		inception.get_node("CanvasModulate").color = Color(0.8,0.8,0.8,1)
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
		GUI = get_node("CanvasLayer/GUI")
		self.connect("objectivescomplete", GUI, "_All_Done") #Not sure why I used a signal here but it works
#	elif self.name == "StrippedMap":
#		var fog = Sprite.new()
#		#I'm sorry
#		self.add_child_below_node(get_tree().get_root().get_node(get_tree().get_root().get_child(0).name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/Objectives"), fog)
#		fog.name = "Fog"
	#else: Debugging
		#print(self.name)
		#print("Whassup")
	

func _objectives_done():
	var objectivesnum = get_node("Objectives").get_children().size()
	done += 1
	print(done)
	if done == objectivesnum:
		print("All Done!")
		emit_signal("objectivescomplete")

