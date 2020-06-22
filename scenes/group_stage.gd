extends Node2D

var team_roster
var idx = -1
var team_list
var team_wins
var team_losses
var team_draws
var game_stat = "none"

func _ready():
	var inst = preload("res://scenes/save.tscn")
	self.add_child(inst.instance())
	team_list = $save.read_save(2,"team_list")
	team_wins = $save.read_save(2,"team_wins")
	team_losses = $save.read_save(2,"team_losses")
	team_draws = $save.read_save(2,"team_draws")
	_print_table()
	get_tree().set_quit_on_go_back(false)
	
func _reset_tournament_save_file():
#	set my_team = none and curr_opponent = none
	pass
	
func _print_table():
	$ItemList.clear()
	for i in range(10):
		$ItemList.add_item(str(i+1)+".")
		$ItemList.add_item(team_list[i])
		$ItemList.add_item(str(team_wins[i]))
		$ItemList.add_item(str(team_draws[i]))
		$ItemList.add_item(str(team_losses[i]))
		$ItemList.add_item(str(team_wins[i]*3+team_draws[i]))
#		$ItemList.add_item(str(i+1)+ ") " + team_list[i] + "\\t" +str(team_wins[i]) + "    " + str(team_draws[i]) + "    " + str(team_losses[i]) + "    " + str(team_wins[i]*3+team_draws[i]))

func _group_stage_handler():
	if idx == -1:
		team_roster = team_list + team_list
		team_roster.erase($save.read_save(2,"my_team"))
	elif idx == 18:
		pass # change this to proceed to semi final
	idx += 1
	$save.save(2,"curr_opponent",team_roster[idx])
	_get_all_match_results()
	
func _get_all_match_results():
	randomize()
	var my_idx = _find_idx_of_team($save.read_save(2,"my_team"))
	var opp_idx = _find_idx_of_team($save.read_save(2,"curr_opponent"))
	var i = 0
	var j = 9
	while true:
		if i == j:
			break;
		elif i  == my_idx or i == opp_idx:
			i += 1
		elif j == my_idx or j == opp_idx:
			j -= 1
		else:
			var res = randi()%11
			if res == 5: # drawn
				team_draws[i] += 1
				team_draws[j] += 1
			elif res < 5: # 'i' won
				team_wins[i] += 1
				team_losses[j] += 1
			else:
				team_wins[j] += 1
				team_losses[i] += 1
			if abs(i-j) == 1:
				break;
			i += 1
			j -= 1

func _my_game_results():
	var my_idx = _find_idx_of_team($save.read_save(2,"my_team"))
	var opp_idx = _find_idx_of_team($save.read_save(2,"curr_opponent"))
	if game_stat == "won":
		team_wins[my_idx] += 1
		team_losses[opp_idx] += 1
	elif game_stat == "lost":
		team_wins[opp_idx] += 1
		team_losses[my_idx] += 1
	elif game_stat == "drawn":
		team_draws[my_idx] += 1
		team_draws[opp_idx] += 1
	else:
		print("error in deciding game_stat")
	_print_table()

func _find_idx_of_team(team_name):
	for i in range(10):
		if team_name == team_list[i]:
			return i
		
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
	
func _on_Back_pressed():
	if $save.read(2,"my_team") != "none":
		$save.save(2,"my_team","none")
	get_tree().change_scene("res://scenes/menu.tscn")

func _on_Button_pressed():
	var game_inst = preload("res://scenes/base_game.tscn")
	_group_stage_handler()
	add_child(game_inst.instance())
