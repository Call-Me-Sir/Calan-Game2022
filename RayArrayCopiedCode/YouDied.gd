extends MarginContainer
var isvisible = self.modulate
var bright = 0
# Called when the node enters the scene tree for the first time.
func _process(delta):
	isvisible.set_modulate(Color(1,1,1,bright))
	bright += 0.001

# Change scene on button press
func _on_LevelSelect_pressed():
	get_tree().change_scene("res://LevelSelect.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://RayArrayCopiedCode/OptionsMenu.tscn")




func _on_Quit_Button_pressed():
	get_tree().quit()
