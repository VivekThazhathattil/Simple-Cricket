extends Node2D

var ins
func _ready():
	print(self.get_path())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_single_player_pressed():
	ins = load("res://scenes/single_player.tscn").instance()
	self.add_child(ins)
#	get_tree().change_scene("res://scenes/single_player.tscn")


func _on_go_back_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("error")

func _on_tournaments_pressed():
	ins = load("res://scenes/tournaments.tscn").instance()
	self.add_child(ins)


func _on_multiplayer_pressed():
	ins = load("res://texture/multiplayer.tscn").instance()
	get_node("/root/menu").add_child(ins)
