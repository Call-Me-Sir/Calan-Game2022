extends MarginContainer
#onready var isvisible = get_node("CanvasModulate")
var bright = 0
# Called when the node enters the scene tree for the first time.


# Change scene on button press
func _on_LevelSelect_pressed():
	get_tree().change_scene("res://LevelSelect.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://RayArrayCopiedCode/OptionsMenu.tscn")




func _on_Quit_Button_pressed():
	get_tree().quit()
