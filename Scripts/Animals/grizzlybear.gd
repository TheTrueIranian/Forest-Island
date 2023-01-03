extends CharacterBody2D

#Checks whether the bear can see the player
var disturbed = false

#Becomes true once the bears disturbance has ended
var noticed = false

#Creates randomization for grizzly movement
var random = RandomNumberGenerator.new()
var random_dir = random.randi_range(1, 4)
var random_distance = random.randi_range(3, 9)

#movement vars
var run_speed = 180
var walk_speed = 20
var dirFacing
var dir = Vector2()
var isMoving = true

#Following Vars
var _position_last_frame := Vector2()
var _cardinal_direction = 0
var previous_position = global_position

#Checks whether or not the Bear is still hitting something
var BearStrike = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$WalkTimer.wait_time = random_distance
	Globals.Grizzly = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if !disturbed and isMoving and !noticed:
		if random_dir == 1:
			velocity.x = 0
			while velocity.y >= -walk_speed:
				velocity.y -= 0.2
			dirFacing = Vector2.UP
			$Anim.play("Walk(U)")
		if random_dir == 2:
			velocity.y = 0
			while velocity.x <= walk_speed:
				velocity.x += 0.2
			dirFacing = Vector2.RIGHT
			$Anim.play("Walk(R)")
		if random_dir == 3:
			velocity.x = 0
			while velocity.y <= walk_speed:
				velocity.y += 0.2
			dirFacing = Vector2.DOWN
			$Anim.play("Walk(D)")
		if random_dir == 4:
			velocity.y = 0
			while velocity.x >= -walk_speed:
				velocity.x -= 0.2
			dirFacing = Vector2.LEFT
			$Anim.play("Walk(L)")
	elif !disturbed and !isMoving and !noticed:
		velocity.x = 0
		velocity.y = 0
		if dirFacing == Vector2.UP:
			$Anim.play("Static(U)")
		if dirFacing == Vector2.DOWN:
			$Anim.play("Static(D)")
		if dirFacing == Vector2.RIGHT:
			$Anim.play("Static(R)")
		if dirFacing == Vector2.LEFT:
			$Anim.play("Static(L)")
			
	elif disturbed and !noticed:
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
			_cardinal_direction = int(4.0 * (motion.rotated(PI / 4.0).angle() + PI) / TAU)
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
		
	if noticed and !disturbed:
		if dirFacing == Vector2.LEFT:
			$Anim.play("Disturbed(L) ")
		elif dirFacing == Vector2.RIGHT:
			$Anim.play("Disturbed(R)")
		elif dirFacing == Vector2.UP:
			$Anim.play("Disturbed(U) ")
		elif dirFacing == Vector2.DOWN:
			$Anim.play("Disturbed(D)")
	
				
	move_and_slide()
		
func is_moving():
	if global_position != previous_position:
		return true
	else:
		return false
		previous_position = global_position	


func _on_walk_timer_timeout():
	$StaticTimer.start()
	isMoving = false


func _on_static_timer_timeout():
	random_dir = random.randi_range(1, 4)
	random_distance = random.randi_range(3, 9)
	$WalkTimer.wait_time = random_distance
	$WalkTimer.start()
	isMoving = true


func _on_attack_body_entered(body):
	if body.name == "Player":
		pass
		


func _on_eyesight_body_entered(body):
	if body.name == "Player" and !BearStrike:
		noticed = true
		$StaticTimer.stop()
		$WalkTimer.stop() 
		#disturbed = true
		#$StaticTimer.stop()
		#$WalkTimer.stop()


func _on_eyesight_body_exited(body):
	if body.name == "Player":
		pass
		#disturbed = false
		#$StaticTimer.start()


func _on_anim_animation_finished():
	if $Anim.animation == "Disturbed(L) " or $Anim.animation == "Disturbed(R)" or $Anim.animation == "Disturbed(U) " or $Anim.animation == "Disturbed(D)":
		disturbed = true
		noticed = false
		


func _on_smash_body_entered(body):
	if body.name != "GrizzlyBear":
		disturbed = false
		noticed = false
		isMoving = false
		BearStrike = true
		$StaticTimer.start()


func _on_smash_body_exited(body):
	BearStrike = false
