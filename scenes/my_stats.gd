extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var save_inst = preload("res://scenes/save.tscn")
	self.add_child(save_inst.instance())
	$my_stats/my_profile/total_games.set_text("Total games played:    " + str($save.read_save(1,"games_played")))
	$my_stats/my_profile/games_won.set_text("Games won:    " + str($save.read_save(1,"games_won")))
	$my_stats/my_profile/games_lost.set_text("Games lost:    " + str($save.read_save(1,"games_lost")))
	$my_stats/my_profile/games_drawn.set_text("Games drawn:    " + str($save.read_save(1,"games_drawn")))
	$my_stats/my_profile/total_tournaments2.set_text("Total tournaments:    " + str($save.read_save(1,"total_tourns")))
	$"my_stats/my_profile/tournaments won".set_text("Tournaments won:    " + str($save.read_save(1,"won_tourns")))
	$"my_stats/my_profile/tournaments lost".set_text("Tournaments lost:    " + str($save.read_save(1,"lost_tourns")))
	$my_stats/my_profile/percent_win_rate.set_text("Percent win rate:    " + str("%0.2f"%($save.read_save(1,"percent_win_rate"))) + " %")
	$my_stats/my_profile/net_run_rate.set_text("Net run rate:    " + str($save.read_save(1,"nrr")))
	$my_stats/my_profile/strike_rate.set_text("Net strike rate:    " + str($save.read_save(1,"nsr")))
	$my_stats/my_profile/economy.set_text("Net economy:    " + str($save.read_save(1,"net_economy")))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_go_back_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
