extends MarginContainer
#var isvisible = self.modulate
var bright = 0
# Called when the node enters the scene tree for the first time.
func _process(delta):
	self.set_modulate(Color(1,1,1,bright))
	if bright < 1:
		bright += 0.01
	print(bright)

# Change scene on button press
func _on_LevelSelect_pressed():
	get_tree().change_scene("res://LevelSelect.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://RayArrayCopiedCode/OptionsMenu.tscn")




func _on_Quit_Button_pressed():
	get_tree().quit()

func _on_Retry_pressed():
	get_tree().reload_current_scene()
