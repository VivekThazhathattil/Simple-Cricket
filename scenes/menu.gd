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
	
func _on_exit_pressed():
	queue_free()
	get_tree().quit()

func _on_music_off_pressed():
	if $bg_music.volume_db == 0:
		$bottom_panel/panel_container/music_off.set_texture("res://sprites/music_off.png")
		$bg_music.volume_db = -80
	else:
		$bottom_panel/panel_container/music_on.set_texture("res://sprites/music_on.png")
		$bg_music.volume_db = 0
	
func _on_sound_off_pressed():
	pass # Replace with function body.
