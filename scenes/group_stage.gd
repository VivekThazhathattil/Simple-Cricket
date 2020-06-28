extends Node2D

#TODO: Add the semifinal and finals and the winner's screen
#TODO: Add save tournament feature

var team_roster
var idx
var team_list
var team_list_short
var team_wins
var team_losses
var team_draws
var game_stat = "none"
var my_idx 
var opp_idx
var tourn_type
var my_team

func _ready():
	var inst = preload("res://scenes/save.tscn")
	self.add_child(inst.instance())
	idx = $save.read_save(2,"match_idx")
	team_list = $save.read_save(2,"team_list")
	team_list_short = $save.team_list_short
	team_wins = $save.read_save(2,"team_wins")
	team_losses = $save.read_save(2,"team_losses")
	team_draws = $save.read_save(2,"team_draws")
	$save.save(2,"tournament_mode",true)
	my_team = $save.read_save(2,"my_team")
	tourn_type = $save.read_save(2,"tourn_type")
	_print_table()
	get_tree().set_quit_on_go_back(false)
	
func _print_table():
	$ItemList.clear()
	var sorted_idx_arr = _sort_table()
	var j = 0
#	var my_team = $save.read_save(2,"my_team")
	var new_my_team_idx
	$ItemList.add_item("S.no")
	$ItemList.add_item("Team")
	$ItemList.add_item("W")
	$ItemList.add_item("D")
	$ItemList.add_item("L")
	$ItemList.add_item("Pts")
#	$ItemList.fixed_icon_size = Vector2(32,32)
	for i in sorted_idx_arr:
		if my_team == team_list[i]:
#			print("my_team = " + my_team + " and team_list[i] = " + team_list[i])
			new_my_team_idx = j
		$ItemList.add_item(str(j+1)+".")
		$ItemList.add_item(team_list_short[i])
		$ItemList.add_item(str(team_wins[i]))
		$ItemList.add_item(str(team_draws[i]))
		$ItemList.add_item(str(team_losses[i]))
		$ItemList.add_item(str(team_wins[i]*3+team_draws[i]))
		j = j + 1
#		$ItemList.add_item(str(i+1)+ ") " + team_list[i] + "\\t" +str(team_wins[i]) + "    " + str(team_draws[i]) + "    " + str(team_losses[i]) + "    " + str(team_wins[i]*3+team_draws[i]))
	_highlight_my_team(new_my_team_idx+1)
	
func _highlight_my_team(new_idx):
#	var new_idx = _find_idx_of_team($save.read_save(2,"my_team"))
	$ItemList.set_item_custom_bg_color((new_idx)*6,Color(0,1,0.4,0.5))
	$ItemList.set_item_custom_bg_color((new_idx)*6+1,Color(0,1,0.4,0.5))
	$ItemList.set_item_custom_bg_color((new_idx)*6+2,Color(0,1,0.4,0.5))
	$ItemList.set_item_custom_bg_color((new_idx)*6+3,Color(0,1,0.4,0.5))
	$ItemList.set_item_custom_bg_color((new_idx)*6+4,Color(0,1,0.4,0.5))
	$ItemList.set_item_custom_bg_color((new_idx)*6+5,Color(0,1,0.4,0.5))	
	
func _sort_table():
	var point_arr = []
	var idx_arr = []
	for i in range(10):
		point_arr.append(team_wins[i]*3+team_draws[i])
	var dup_arr = [] + point_arr
	point_arr.sort()
	var i = 0
	var j
	while i < 10:
		j = 0
		while j < 10:
			if dup_arr[j] == point_arr[i]:
				idx_arr.append(j)
				dup_arr[j] = -1
				break
			else:
				j += 1
		i += 1
	idx_arr.invert()
	return idx_arr

func _group_stage_handler():
	if tourn_type == "tourn":
		team_roster = [] + team_list
	elif tourn_type == "league":
		team_roster = [] + team_list + team_list + team_list + team_list
	var roster_size = team_roster.size()
	var i = 0
	while i < roster_size:
		if team_roster[i] == my_team:
			team_roster.remove(i)
			roster_size -= 1
		i += 1
	print(str(team_roster))
	idx += 1
#	print("team roster = " + str(team_roster))
#	print("idx = " + str(idx))
	if idx < 9 and tourn_type == "tourn":
		$save.save(2,"curr_opponent",team_roster[idx])
		_get_all_match_results()
	elif idx < 36 and tourn_type == "league":
		$save.save(2,"curr_opponent",team_roster[idx])
		_get_all_match_results()
	elif idx == 36 and tourn_type == "league":
		_league_results_decider()
	else:
		_semi_final_handler()
		
func _league_results_decider():
	pass

func _semi_final_handler():
	pass
		
func _get_all_match_results_stub():
	randomize()
	my_idx = _find_idx_of_team($save.read_save(2,"my_team"))
	opp_idx = _find_idx_of_team($save.read_save(2,"curr_opponent"))
	var i = 0
	var j = 9
	var les
	var hi
	var les_idx

	while true:
		if i == j:
			break;
		elif i  == my_idx or i == opp_idx:
			i += 1
		elif j == my_idx or j == opp_idx:
			j -= 1
		else:
			if $save.team_probs[i] < $save.team_probs[j]:
				les = float($save.team_probs[i])/($save.team_probs[i] + $save.team_probs[j])
				hi = float($save.team_probs[j])/($save.team_probs[i] + $save.team_probs[j])
				les_idx = i
			else:
				les = float($save.team_probs[j])/($save.team_probs[i] + $save.team_probs[j])
				hi = float($save.team_probs[i])/($save.team_probs[i] + $save.team_probs[j])
				les_idx = j
			var res = randf()
#			print("res = " + str(res) + " for teams " + $save.team_list[i] + " and " + $save.team_list[j])
#			print("team_probs : " + $save.team_list[i] + " " + str($save.team_probs[i]))
#			print("team_probs : " + $save.team_list[j] + " " + str($save.team_probs[j]))
			if res > 0.45 and res < 0.55: # drawn
				team_draws[i] += 1
				team_draws[j] += 1
			elif res > les:
				if les_idx == i:
					team_wins[j] += 1
					team_losses[i] += 1
				else:
					team_wins[i] += 1
					team_losses[j] += 1
			else:
				if les_idx == i:
					team_wins[i] += 1
					team_losses[j] += 1
				else:
					team_wins[j] += 1
					team_losses[i] += 1
			if abs(i-j) == 1:
				break;
			i += 1
			j -= 1

func _get_all_match_results():
	randomize()
	my_idx = _find_idx_of_team($save.read_save(2,"my_team"))
	opp_idx = _find_idx_of_team($save.read_save(2,"curr_opponent"))
	var temp_arr = []
	for i in range(10):
		temp_arr.append(i)
	var i = 0
	var j = 1
	var token_rand = 0
	temp_arr[my_idx] = -1
	temp_arr[opp_idx] = -1
	for _i in 4: # change hardcoded 4 to the relative team list size
		i = randi()%10
		while i < 10:
			if temp_arr[i] == -1:
				i += 1
				if i == 10:
					i = 0
			else:
				temp_arr[i] = -1
				break
		j = randi()%10
		while j < 10:
			if temp_arr[j] == -1:
				j += 1
				if j == 10:
					j = 0
			else:
				temp_arr[j] = -1
				break
		print("i = " + str(i) + " and j = " + str(j))
		token_rand = randf()
		if token_rand < 0.55 and token_rand > 0.50:
			team_draws[i] += 1
			team_draws[j] += 1
		elif $save.team_probs[i] < $save.team_probs[j] and token_rand < 0.9:
			team_wins[j] += 1
			team_losses[i] += 1
		else:
			team_wins[i] += 1
			team_losses[j] += 1

func _my_game_results():
	my_idx = _find_idx_of_team($save.read_save(2,"my_team"))
	opp_idx = _find_idx_of_team($save.read_save(2,"curr_opponent"))
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
#	print("team_name = " + team_name)
	for i in range(10):
#		print("i = " + str(i))
#		print("team_list[i] = " + team_list[i])
		if team_name == team_list[i]:
			return i
		
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
	
func _on_Back_pressed():
	if $save.read(2,"tournament_mode"):
		$save.save(2,"tournament_mode",false)
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")

func _on_Button_pressed():
	var game_inst = preload("res://scenes/base_game.tscn")
	_group_stage_handler()
	add_child(game_inst.instance())


func _on_save_tourn_pressed():
	$PopupPanel.popup()
	yield(get_tree().create_timer(0.5),"timeout")
	$PopupPanel.hide()
	$save.save(2,"match_idx",idx)
	$save.save(2,"team_wins", team_wins)
	$save.save(2,"team_losses", team_losses)
	$save.save(2,"team_draws", team_draws)
