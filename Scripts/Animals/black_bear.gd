extends CharacterBody2D

#Activates when black bear wakes up from player
var disturbed = true

#movement vars
var run_speed = 180
var dirFacing
var dir = Vector2()
var isMoving = true

#Following Vars
var _position_last_frame := Vector2()
var _cardinal_direction = 0
var previous_position = global_position

func _ready():
	pass

func _physics_process(delta):
	pass
