extends CharacterBody2D

const speed = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	zoom()

func move(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()


func zoom():
	if Input.is_action_just_released("scroll_up"):
		$Camera2D.zoom += Vector2(0.1, 0.1)
	if Input.is_action_just_released("scroll_down"):
		$Camera2D.zoom += Vector2(-0.1, -0.1)
