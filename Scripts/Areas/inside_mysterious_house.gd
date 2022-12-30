extends TileMap

#Checks whether player can leave or not
var leave_building = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_pressed("Interact") and leave_building:
		get_tree().change_scene_to_file("res://Scenes/tile_map.tscn")
	



func _on_leave_body_entered(body):
	if body.name == "Player":
		leave_building = true


func _on_leave_body_exited(body):
	if body.name == "Player":
		leave_building = false


func _on_tree_exited():
	Globals.playerLeftMysteriousHouse = true
