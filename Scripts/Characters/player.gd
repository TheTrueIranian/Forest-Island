extends CharacterBody2D

#movement vars
var run_speed = 180
var walk_speed = 50
var is_walking = false
var dirFacing
var dir = Vector2()
var can_move = true

func _ready():
	#Makes Players stuff global
	Globals.Player = self
	
	#These if statements tell the game to spawn the player outside the respectvie building properly
	if Globals.playerLeftShed:
		position.x = -3667
		position.y = -1186
		Globals.playerLeftShed = false
		
	if Globals.playerLeftMysteriousHouse:
		position.x = 5228
		position.y = 1721
		Globals.playerLeftMysteriousHouse = false
		
	if Globals.playerLeftShop:
		position.x = 4934
		position.y = -4146
		Globals.playerLeftShop = false
		

func _process(delta):
	#Creates a shadow under buildings
	if Globals.underShadow:
		modulate = Color.DARK_GRAY
	else:
		modulate = Color.WHITE



func _physics_process(_delta):
	if Input.is_action_pressed("Forward (Run)") and can_move:
		velocity.x = 0
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.y = 0
			is_walking = true
			while velocity.y >= -walk_speed:
				velocity.y -= 0.2
			dirFacing = Vector2.UP
			$Anim.play("WalkUp(M)")
		elif !Input.is_key_pressed(KEY_SHIFT):
			is_walking = false
			while velocity.y >= -run_speed:
				velocity.y -= 0.5
			dirFacing = Vector2.UP
			$Anim.play("RunUp(M)")
	elif Input.is_action_pressed("Down (Run)") and can_move:
		velocity.x = 0
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.y = 0
			is_walking = true
			while velocity.y <= walk_speed:
				velocity.y += 0.2
			dirFacing = Vector2.DOWN
			$Anim.play("WalkDown(M)")
		elif !Input.is_key_pressed(KEY_SHIFT):
			is_walking = false
			while velocity.y <= run_speed:
				velocity.y += 0.5
			dirFacing = Vector2.DOWN
			$Anim.play("RunDown(M)")
	elif Input.is_action_pressed("Right (Run)") and can_move:
		velocity.y = 0
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.x = 0
			is_walking = true
			while velocity.x <= walk_speed:
				velocity.x += 0.2
			dirFacing = Vector2.RIGHT
			$Anim.play("WalkRight(M)")
		elif !Input.is_key_pressed(KEY_SHIFT):
			is_walking = false
			while velocity.x <= run_speed:
				velocity.x += 0.5
			dirFacing = Vector2.RIGHT
			$Anim.play("RunRight(M)")
	elif Input.is_action_pressed("Left (Run)") and can_move:
		velocity.y = 0
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.x = 0
			is_walking = true
			while velocity.x >= -walk_speed:
				velocity.x -= 0.2
			dirFacing = Vector2.LEFT
			$Anim.play("WalkLeft(M)")
		elif !Input.is_key_pressed(KEY_SHIFT):
			is_walking = false
			while velocity.x >= -run_speed:
				velocity.x -= 0.5
			dirFacing = Vector2.LEFT
			$Anim.play("RunLeft(M)")
		
	if dirFacing == Vector2.UP and !Input.is_action_pressed("Forward (Run)") and !Input.is_action_pressed("Forward (Walk)"):
		velocity.x = 0
		velocity.y = 0
		$Anim.play("IdleUp(M)")
	elif dirFacing == Vector2.DOWN and !Input.is_action_pressed("Down (Run)") and !Input.is_action_pressed("Down (Walk)"):
		velocity.x = 0
		velocity.y = 0
		$Anim.play("IdleDown(M)")
	elif dirFacing == Vector2.RIGHT and !Input.is_action_pressed("Right (Run)") and !Input.is_action_pressed("Right (Walk)"):
		velocity.x = 0
		velocity.y = 0
		$Anim.play("IdleRight(M)")
	elif dirFacing == Vector2.LEFT and !Input.is_action_pressed("Left (Run)") and !Input.is_action_pressed("Left (Walk)"):
		velocity.x = 0
		velocity.y = 0
		$Anim.play("IdleLeft(M)") 
	

	move_and_slide()
