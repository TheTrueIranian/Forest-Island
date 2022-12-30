extends AnimatedSprite2D

#Checks whether player can enter or not
var enter_building = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Input.is_action_pressed("Interact") and enter_building:
		play("Door Open")
		

func _on_interaction_body_entered(body):
	if body.name == "Player":
		enter_building = true
		


func _on_interaction_body_exited(body):
	if body.name == "Player":
		enter_building = false


func _on_animation_finished():
	if animation == "Door Open":
		get_tree().change_scene_to_file("res://Scenes/TileMap(s)/inside_mysterious_house.tscn")
		
