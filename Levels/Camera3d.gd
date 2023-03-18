extends Camera3D

@onready var player = get_node ("../Adam")
@onready var player2 = get_node ("../John")

func _process(_delta):
	transform.origin.x = player.transform.origin.x
	transform.origin.x = player2.transform.origin.x
