extends Camera2D

var target_position = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()

	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20)) 
	
	if !is_moving_diagonal():
		self.global_position = self.global_position.round()
		
#	print("Camera POS Y", global_position.y)
#	print("Camera POS X", global_position.x)


func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	
	if player_nodes.size() > 0:
		var my_player:Node2D = player_nodes[0]
		target_position = my_player.global_position
		

func is_moving_diagonal() -> bool:
	var moving_left = Input.is_action_pressed("move_left")
	var moving_right = Input.is_action_pressed("move_right")
	var moving_up = Input.is_action_pressed("move_up")
	var moving_down = Input.is_action_pressed("move_down")

	# If moving diagonally, two non-parallel directions will be true at the same time
	var is_moving_diagonal = (moving_left and moving_up) or (moving_left and moving_down) 
	is_moving_diagonal = is_moving_diagonal or (moving_right and moving_up) or (moving_right and moving_down)

	return is_moving_diagonal

