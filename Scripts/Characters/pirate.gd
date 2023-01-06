extends CharacterBody2D

#Dialogue vars
var first_meeting = load("res://Dialogue/Pirate/First Meeting/pirate_first_meeting.dialogue")


#Checks if the pirate is talking
var isTalking = false

#Stores all possible riddles
var riddles = ["Ye'd hate to lose me, and sometimes hate to gain me. Without me the world would fall apart, but I can also make ye fall apart. What am I?",
			"A mother, father, and their two kids lived in an apartment. There was a soda in the fridge that belonged to one of them kids. One day, the mother found it missing to where it usually was . Who drank the soda?",
			"When ye hear this phrase, ye know ye're in big trouble. As a pirate, we hear this daily. What's it?",
			"I am usually put on food, but ye can also purchase lessons for me. What am I?"]
			
#Gets random riddle
var riddle_chosen = riddles[randi() % riddles.size()]

#Checks if player is able to interact w/ pirate
var playerInteraction = false

#Checks if the player has met the pirate or not
var hasMet = false

func _ready():
	Globals.Pirate = self


func _physics_process(delta):
	if isTalking:
		$Anim.play("Talking")
	
	if playerInteraction:
		if Input.is_action_pressed("Interact") and !hasMet:
			await DialogueManager.get_next_dialogue_line(first_meeting, "start")
		
	


func _on_interact_body_entered(body):
	if body.name == "Player":
		playerInteraction = true


func _on_interact_body_exited(body):
	if body.name == "Player":
		playerInteraction = false
