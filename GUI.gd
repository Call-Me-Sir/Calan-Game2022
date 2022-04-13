extends MarginContainer


# Declare member variables here. Examples:
onready var oxygen = $VBoxContainer/TopUi/OxygenMeter/Oxynum
onready var oxygenmeter = $VBoxContainer/TopUi/Control/ProgressBar
onready var depthnum = $VBoxContainer/TopUi/DepthMeter/Depthnum
#onready var ObjectivesList = $VBoxContainer/Objectives
var air
var air_capacity = 200
onready var player = get_parent().get_parent().get_node("TheDiver")
onready var levelobjectives = get_parent().get_parent().get_node("Objectives")
onready var player_depth 
var objectives = []
var objectiveslabel = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in 15:
		get_node("VBoxContainer/Objectives/Label" + str(c+1)).set_text("")
		objectiveslabel.push_back(get_node("VBoxContainer/Objectives/Label" + str(c+1)))
	air = air_capacity
	$VBoxContainer.add_constant_override("separation",20)
	for i in levelobjectives.get_children():
		objectives.push_back(i)
	for i in 15:
		get_node("VBoxContainer/Objectives/Label" + str(i+1)).text = objectives[i].name
		if objectives.size() < i+2:
			print("hello")
			print(i)
			print(objectives.size())
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_depth = player.player_depth
	air -= delta
	oxygen.text = str(stepify(air,0.1))
	oxygenmeter.value = air/(air_capacity/100)
	depthnum.text = str("%03d" % stepify(player_depth/30,1)) + "m"
	if air <= 0:
		print("You died!")
	if Input.is_action_just_pressed("Debug"):
		for i in objectives:
			print(i.name)
	for i in objectives.size():
		if objectives[i].is_in_group("Complete") and objectives[i].vardone == 2:
			objectiveslabel[i].text = objectiveslabel[i].text + " [Done]"
			objectives[i].vardone = 3
