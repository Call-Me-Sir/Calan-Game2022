extends Node

#onready var canvas = $CanvasModulate
var userinterface = preload("res://TrueGui.tscn")
var minidiver = preload("res://MinimapDiver.tscn")
#var level = load("res://" + self.name + ".tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var inception = self.duplicate()
	inception.name = "StrippedMap"
	var minimapdiver = minidiver.instance()
	var gui = userinterface.instance()
	add_child(gui)
	if self.name != "StrippedMap":
		get_tree().get_root().get_node("Tutorial/CanvasLayer/ViewportContainer/Viewport").add_child(inception)
		get_tree().get_root().get_node("Tutorial/CanvasLayer/ViewportContainer/Viewport/StrippedMap/TheDiver").queue_free()
	get_tree().get_root().get_node("Tutorial/CanvasLayer/ViewportContainer/Viewport/StrippedMap/TheDiver").add_child(minimapdiver)
# 	Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#var canvaschange = diver.player_depth/15300 #Specific Number: 255(255 in editor = 1 in color) * 30 (Playerdepth/30 = UI depth
	#canvas.color = Color(0.65-canvaschange,0.65-canvaschange,0.65-canvaschange)
