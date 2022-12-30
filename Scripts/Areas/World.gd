extends TileMap

var player_position = null


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.World = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	#Grab player position from Globals file
		player_position = $Player.position - $GrizzlyBear.position
		player_position = player_position.normalized()
		print(str(player_position) + " World")
		
