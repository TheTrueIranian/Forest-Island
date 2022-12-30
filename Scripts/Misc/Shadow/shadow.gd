extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_darken_body_entered(body):
	if body.name == "Player":
		Globals.underShadow = true


func _on_darken_body_exited(body):
	if body.name == "Player":
		Globals.underShadow = false
