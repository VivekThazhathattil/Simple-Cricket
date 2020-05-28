extends Node2D
var no_overs = 1
var new_game = preload("res://scenes/base_game.tscn")
var my_stats = preload("res://scenes/my_stats.tscn")
var how_to_play = preload("res://scenes/how_to_play.tscn")

func _ready():
	print(self.get_path())
	pass

func _on_PLAY_NOW_pressed():
	var ins = load("res://scenes/game_mode.tscn").instance()
	self.add_child(ins)

func _on_MY_PROFILE_pressed():
	var ins = my_stats.instance()
	self.add_child(ins)

func _on_HOW_TO_PLAY_pressed():
	var ins = how_to_play.instance()
	self.add_child(ins)
