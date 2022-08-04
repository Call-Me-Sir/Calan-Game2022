extends Node

#For Fog of diving/war, not that there is much of the latter
const Light1 = preload("res://Resources/NarrowBeam.png")
const Light2 = preload("res://Resources/SmolLight.png")
var FOW = preload("res://FogOfWar.tscn")
#const somethingscale = 4
var LightTexture1 = Light1.get_data()
var LightTexture2 = Light2.get_data()
#var display_width = ProjectSettings.get("display/window/size/width")
#var display_height = ProjectSettings.get("display/window/size/height")
var fogImage = Image.new()
var fogTexture = ImageTexture.new()
#onready var FogBegin = get_node("FogStart")
#onready var FogEndin = get_node("FogEnd")
var lightImage2 = Light2.get_data()
var Player
var FogBegin
var FogEndin
var light_offset2 = Vector2(LightTexture2.get_width(), LightTexture2.get_height())
var fog
var fogx
var fogy
var newfog
# Called when the node enters the scene tree for the first time.
func startup(): #Look in tutorial code to reactivate
	#fog = Sprite.new()
	#add_child_below_node(get_node("MinimapDiver"), fog)
	#fog.set_centered(false)
	newfog = $"FogOfWar"
	print(str(newfog.name) + "Says Hi")
	newfog.set_fog_color(Color(0.0, 0.0, 0.0, 1.0))
	FogBegin = get_node("FogStart")
	FogEndin = get_node("FogEnd")
	Player = get_node("MinimapDiver")
	fogx = (FogEndin.get_position().x - FogBegin.get_position().x)
	fogy = FogEndin.get_position().y - FogBegin.get_position().y
	var extent = Vector2(fogx, fogy)
	newfog.level_start(extent, FogBegin.position, Vector2(0.2,0.2))
	print("Ah")
	#Extent of fog

	#var extent = Vector2(fogx, fogy)
	#fog.global_position = FogBegin.get_global_position()
	#print(fog.get_global_position())
	
	#fog.position.x = fog.position.x + fogx/2
	#fog.position.y = fog.position.y + fogy/2
	#Stupid set_centered feature
	
	#I'm sorry
	#self.add_child_below_node(get_tree().get_root().get_node(get_tree().get_root().get_child(0).name + "/CanvasLayer/ViewportContainer/Viewport/StrippedMap/Objectives"), fog)

	#fog.name = "Fog"
	#fogImage.create(fogx, fogy, false, Image.FORMAT_RGBAH)
	#fogImage.fill(Color.black)
	
	#fogImage.position = FogBegin.position
	#lightImage2.convert(Image.FORMAT_RGBAH)
	#fog.scale *= 1
	
	#newfog = $FogTiles#TileMap.new()
	#newfog.cell_size= Vector2(32,32)
	

func update_fog(new_grid_position):
	fogImage.lock()
	lightImage2.lock()
	var light_rect2 = Rect2(Vector2.ZERO, Vector2(lightImage2.get_width(), lightImage2.get_height()))
	fogImage.blend_rect(lightImage2, light_rect2, new_grid_position - light_offset2 - fog.global_position) #+ Vector2(fogx/2,0))
	fogImage.unlock()
	lightImage2.unlock()
	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture.create_from_image(fogImage)
	fog.texture = fogTexture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#update_fog(Player.get_global_position())
	pass
