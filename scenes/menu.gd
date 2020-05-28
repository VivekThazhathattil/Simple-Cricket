extends Node2D

func _ready():
	pass

func _on_PLAY_NOW_pressed():
	get_tree().change_scene("res://scenes/base_game.tscn")
