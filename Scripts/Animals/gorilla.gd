extends CharacterBody2D

#Checks if the player has talked to the mysterious man
var playerTalkedToMysteriousMan = false

#Activates if gorilla is alert and plaeyr disrupts her
var disturbed = false

#Activated when player has succesfully tired out the gorilla
var gassed = false

#Literally just so it can play the alert animation lmao
var alerted = false

#movement vars
var run_speed = 165
var dirFacing
var dir = Vector2()

#Following Vars
var _position_last_frame := Vector2()
var _cardinal_direction = 0
var previous_position = global_position

func _ready():
	Globals.Gorilla = self
	playerTalkedToMysteriousMan = true
	
func _process(delta):
	if playerTalkedToMysteriousMan:
		$Eyesight/CollisionShape2D.disabled = false

func _physics_process(delta):
	#Wakes the gorilla up if the player talks to the mysterious man
	if !playerTalkedToMysteriousMan:
		$Anim.play("Sleep")
		velocity.x = 0
		velocity.y = 0
	elif playerTalkedToMysteriousMan and !disturbed and !gassed and !alerted:
		$Anim.play("Alert")
		velocity.x = 0
		velocity.y = 0
	elif playerTalkedToMysteriousMan and disturbed and !gassed and !alerted:
		#Grab player position from Globals file
		var player_position = Globals.Player.global_position - global_position
		player_position = player_position.normalized()
		move_and_collide(player_position * run_speed * delta)
		#Get motion vector between previous and current position
		var motion = position - _position_last_frame
		
		# If the node actually moved, we'll recompute its direction.
		# If it didn't, we'll just the last known one.
		if motion.length() > 0.0001:
			# Now if you want a value between N.S.W.E,
			# you can use the angle of the motion.
			_cardinal_direction = int(3.9 * (motion.rotated(PI / 3.9).angle() + PI) / TAU)
		# You can also use it with an array since it's like an index
		match _cardinal_direction:
			0:
				$Anim.play("Run(L)")
				dirFacing = Vector2.LEFT
			1:
				$Anim.play("Run(U)")
				dirFacing = Vector2.UP
			2:
				$Anim.play("Run(R)")
				dirFacing = Vector2.RIGHT
			3:
				$Anim.play("Run(D)")
				dirFacing = Vector2.DOWN

		# Remember our current position for next frame
		_position_last_frame = position
		
	if gassed:
		velocity.x = 0
		velocity.y = 0
		if dirFacing == Vector2.LEFT:
			$Anim.play("Gassed(L)")
			$CollisionShape2D.disabled = true
			$CollisionShape2D2.disabled = false
		elif dirFacing == Vector2.RIGHT:
			$Anim.play("Gassed(R)")
			$CollisionShape2D.disabled = true
			$CollisionShape2D2.disabled = false
		elif dirFacing == Vector2.UP:
			$Anim.play("Gassed(U)")
		elif dirFacing == Vector2.DOWN:
			$Anim.play("Gassed(D)")
			
	if alerted and !disturbed and !gassed:
		$Anim.play("Alerted")

func is_moving():
	if global_position != previous_position:
		return true
	else:
		return false
		previous_position = global_position	

func _on_eyesight_body_entered(body):
	if body.name == "Player" and playerTalkedToMysteriousMan:
		alerted = true


func _on_anim_animation_finished():
	if $Anim.animation == "Alerted":
		alerted = false
		disturbed = true
		$RunTimer.start()


func _on_run_timer_timeout():
	#The tooth is able to be pulled out for the man and the gorilla is gassed
	gassed = true
	pass 
