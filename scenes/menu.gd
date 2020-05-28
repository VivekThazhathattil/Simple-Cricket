extends Node2D
var no_overs = 1
var new_game = preload("res://scenes/base_game.tscn")
func _ready():
	print(self.get_path())
	pass

func _on_PLAY_NOW_pressed():
	var ins = load("res://scenes/game_mode.tscn").instance()
	self.add_child(ins)
	#get_tree().change_scene("res://scenes/game_mode.tscn")
