extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_nodes = get_tree().get_nodes_in_group("player")
	
	if player_nodes.size() > 0:
		var my_player:Node2D = player_nodes[0]
		global_position = my_player.global_position
		align()
