extends Node

onready var pausemenu = load("res://RayArrayCopiedCode/OptionsMenu.tscn")
var paused

var keybinds = {}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	if get_parent().get_child(1).get_class() == "Node":
		VisualServer.set_default_clear_color(Color(0,0,0))
		pass
	
func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		if get_parent().get_child(1).get_class() == "Node": #All Levels must have a "Node" as their top node!
			#get_child(0) is just the Global.gd node. get_child(1) is the level. You can see in the remote scene tree
			#paused = true
			get_parent().get_child(1).get_node("CanvasLayer").add_child(pausemenu.instance())
			get_tree().set_pause(true)

