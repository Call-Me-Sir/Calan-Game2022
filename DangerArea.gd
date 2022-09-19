extends Area2D


# Declare member variables here. Examples:
onready var danger = $RigidBody2D
var shape
var activated = false


func _on_DangerArea_body_entered(body):
	if body.name == "TheDiver" and activated == false:
		danger.set_gravity_scale(0.5)
		shape = $RigidBody2D/Polygon2D
		shape.fragment()
		activated = true
	
