extends Panel


# Declare member variables here. Examples:
onready var player = get_node("../../Level Diver")
var areaname

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button").text = "Play " + areaname


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://" + str(areaname) + ".tscn")


func _on_Button2_pressed():
	player.levelplay = false
	queue_free()
