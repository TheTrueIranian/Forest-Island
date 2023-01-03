extends TileMap

#Creates randomization for black bear spawn
var random = RandomNumberGenerator.new()
var random_x = random.randi_range(-1600, -1700)
var random_y = random.randi_range(3300, 3400)

func _ready():
	Globals.World = self
	Globals.Grizzly.position.x = -3614
	Globals.Grizzly.position.y = -4050
	Globals.BlackBear.position.x = random_x
	Globals.BlackBear.position.y = random_y
	Globals.Gorilla.position.x = 4453
	Globals.Gorilla.position.y = -400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#If the player has alerted gorilla, then they'll be greeted to a prompt that tells them that the area will be closed off if they proceed, this actiavetes that prompt if the player enters the area
	if Globals.Gorilla.playerTalkedToMysteriousMan:
		$"Gorilla Activation/CollisionShape2D".disabled = false


func _on_ghost_food_area_entered(area):
	if area.name == "AttackGhostBear":
		Globals.BlackBear.isEating = true
