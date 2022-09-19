extends ColorRect

var can_change_key = false
var action_string
enum ACTIONS {ui_left, ui_right, ui_up, ui_down, SpeedSide, SpeedUp, UIShowHide, ui_cancel}

func _ready():
	visible = true
	#get_parent().move_child(self,-1)
	_set_keys()
	#Back To Level
	#if Master.current_level != null:
		
	#	$Panel/ScrollContainer/VBoxContainer/Button2.text = "Back to Level " + str(Master.current_level)
	#else:
	#	$Panel/ScrollContainer/VBoxContainer/Button2.hide()


func _process(_delta):
	if get_tree().get_root().has_node("/root/OptionsMenu") and has_node("Panel/ScrollContainer/VBoxContainer/Button2"):
		get_node("Panel/ScrollContainer/VBoxContainer/Button2").queue_free()
	#if Input.is_action_just_pressed("ui_cancel"):
	#	visible = not visible
	
func _set_keys():
	for j in ACTIONS:
		get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_pressed(false)
		#Gets default actions from inputMap
		if !InputMap.get_action_list(j).empty():
			#if str(j) == "Tool" or str(j) == "Look":
			#	get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_text("No Button!")
			#else:
			get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
		#No button code
		else:
			get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_text("No Button!")
			
#When change key button is pressed, make it changable. 
func _mark_button(string):
	can_change_key = true
	action_string = string
	#If another button was changable, make it not so.
	for j in ACTIONS:
		if j != string:
			get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_pressed(false)

#When button is changable and button is pressed, change input to that button (Input is a default function)
func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false

func _change_key(new_key):
	#Delete key of pressed button
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	#Check if new key was assigned somewhere, if so delete
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	#Add new Key
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()

#Click the button to make it changable
func back_to_main_menu():
	get_tree().change_scene("res://RayArrayCopiedCode/Main Menu.tscn")
	get_tree().set_pause(false)
	
func back_to_level():
	get_tree().paused = false
	print("eas")
	queue_free()

	#get_tree().change_scene("res://Levels/Level " + str(Master.current_level) + ".tscn")

func change_key_UIShowHide():
	_mark_button("UIShowHide")

func change_key_DeployPickup():
	_mark_button("ui_cancel")

func change_key_Slowdown():
	_mark_button("SpeedSide")

func change_key_Speedup():
	_mark_button("SpeedUp")

func change_key_moveup():
	_mark_button("ui_up")

func change_key_moveleft():
	_mark_button("ui_left")

func change_key_moveright():
	_mark_button("ui_right")

func change_key_movedown():
	_mark_button("ui_down")
