extends Node

onready var canvas = $CanvasModulate
onready var diver = $TheDiver

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#var canvaschange = diver.player_depth/15300 #Specific Number: 255(255 in editor = 1 in color) * 30 (Playerdepth/30 = UI depth
	#canvas.color = Color(0.65-canvaschange,0.65-canvaschange,0.65-canvaschange)
