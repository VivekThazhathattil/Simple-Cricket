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
	get_tree().change_scene("res://scenes/menu.tscn")
