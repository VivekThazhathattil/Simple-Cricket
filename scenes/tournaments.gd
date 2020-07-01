extends Node2D
var inst = preload("res://scenes/icc.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var save_inst = preload("res://scenes/save.tscn")
	add_child(save_inst.instance())
	if $save.read_save(2,"saved_tourn"):
		$VBoxContainer/Continue_tournament.visible = true
	else:
		$VBoxContainer/Continue_tournament.visible = false

func _on_go_back_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")

func _on_T20_international_cup_pressed():
	$VBoxContainer.visible = false
	$save.save(2,"team_wins",$save.team_wins)
	$save.save(2,"team_losses",$save.team_losses)
	$save.save(2,"team_draws",$save.team_draws)
	$save.save(2,"saved_tourn",true)
	$save.save(2,"match_idx",-1)
	$save.save(2,"overs",10)
	$save.save(2,"tourn_type","tourn")
	$save.save(2,"progress","group stage")
	add_child(inst.instance())


func _on_Continue_tournament_pressed():
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_Nations_league_pressed():
	$VBoxContainer.visible = false
	$save.save(2,"team_wins",$save.team_wins)
	$save.save(2,"team_losses",$save.team_losses)
	$save.save(2,"team_draws",$save.team_draws)
	$save.save(2,"saved_tourn",true)
	$save.save(2,"match_idx",-1)
	$save.save(2,"overs",10)
	$save.save(2,"tourn_type","league")
	$save.save(2,"progress","group stage")
	add_child(inst.instance())


func _on_international_cup_pressed():
	$VBoxContainer.visible = false
	$save.save(2,"team_wins",$save.team_wins)
	$save.save(2,"team_losses",$save.team_losses)
	$save.save(2,"team_draws",$save.team_draws)
	$save.save(2,"saved_tourn",true)
	$save.save(2,"match_idx",-1)
	$save.save(2,"overs",1)
	$save.save(2,"tourn_type","tourn")
	$save.save(2,"progress","group stage")
	add_child(inst.instance())
