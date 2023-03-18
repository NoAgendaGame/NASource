extends CanvasLayer

var money = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Money.text = str(money)

func _physics_process(_delta):
		if money == 99:
			get_tree().change_scene_to_file("res://Levels/ap_office.tscn")
	

func _on_money_collected():
	money = money + 1
	_ready()
