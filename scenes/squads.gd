# TODO: Add bowling stats to the score card
# TODO: Add other stats to the scorecard
# TODO: Add option to edit the squad and save the change permanently
# TODO: Add option to load the squads from the local save file
# TODO: Add loading screen for tournament 

extends Node2D

var IND_squad = [
"Rwohit Shwarma",
"Shwikar Dhwawan",
"Vwirat Kwohli",
"M S Dhwoni",
"Kwedar Jwadav",
"Dwinesh Kwarthik",
"Hwardik Pwandia",
"Rwavi Jwadeja",
"Bhwuvaneshwar Kwumar",
"Ywujveendra Chwahal",
"Jwasprith Bwumrah"
]

var PAK_squad = [
"Swarfaraz Ahwmed",
"Fwakhar Zwaman ",
"Imwam-ul-Hwaq",
"Bwabar Awzam",
"Shwoaib Mwalik",
"Shahween Awfridi",
"Mwohammad Hwafeez",
"Imwad Wwasim",
"Jwunaid Khwan",
"Mwohammad Hwasnain",
"Hwaris Swohail"
]

var ENG_squad = [
"Ewoin Mworgan",
"Jwonny Bwairstow",
"Jwoe Rwoot",
"Bwen Stwokes",
"Mwoeen Awli",
"Chwris Wwoakes",
"Jwose Bwutler",
"Jwofra Awrcher",
"Lwiam Pwlunkett",
"Awdil Rwasheed",
"Mwark Wwood",
]

var SL_squad = [
"Dwimuth Kwarunaratne",
"Kwusal Pwerera",
"Lwahiru Thwirimanne",
"Kwusal Mwendies",
"Awnjelo Mwatthews",
"Dhwananjaya Dwesilva", 
"Jweewan Mwendis",
"Iswuru Udwana",
"Thwisara Pwerera",
"Swuranga Lwakmal",
"Lwasith Mwalinga"
]

var BAN_squad = [
"Twamim",
"Lwiton",
"Souwmya",
"Mwusfiq",
"Shwakib",
"Mahwmudullah",
"Mwahedi",
"Afwif",
"Swaifuddin",
"Mwustafizur",
"Rwubel"
]

var AUS_squad = [
"Awaron Fwinch",
"Dwavid Wwarner",
"Stweve Smwith",
"Glwenn Maxwwell",
"Mitwchell Mwarsh",
"Alwex Cwarey",
"Ashtwon Agwar",
"Pwat Cwummins",
"Mitchwell Stwarc",
"Kwane Richwardson",
"Adwam Zwampa"
]

var NZ_squad = [
"Mwartin Gwuptill",
"Cwolin Mwunro",
"Kwane Wwilliamson",
"Rwoss Twaylor",
"Twim Swaiferd",
"Jwems Nwisham",
"Mitschwell Swentner",
"Cwolin De Gwrandhome",
"Twrend Bwold",
"Iwsh Swody",
"Lokwii Fwerguson"
]

var WI_squad = [
"Ewvin Lwewis ",
"Lwendl Swimmons",
"Swimron Hwetmyr",
"Nwicolas Pwooran",
"Awndre Rwussel",
"Kwiron Pwollard ",
"Dwwayne Bwravo",
"Cwarlos Bwrethwait",
"Swunil Nwarayan",
"Sweldon Cwottrell",
"Kwesrik Wwilliams"
]

var AFG_squad = [
"Zwazai",
"Gwulbadin",
"Rwahmat",
"Gwurbaz",
"Awsghar",
"Nwabi",
"Rwashid",
"Qwais Ahwmad",
"Mwujeeb",
"Awftab Awlam",
"Dwawlat Zwadran"
]

var SA_squad = [
"Hwashim Awmla",
"Qwinton Dwe Kwock",
"Rwussie Vwon Dwussen",
"Fwaf Dwu Pwlessis",
"Mwiller ",
"J P Dwuminy ",
"Pwehlukwayo",
"Dwale Swteyn",
"Rwabada ",
"Lwungi Nwgidi",
"Imrwan Twahir"
]
var squad = [AFG_squad, AUS_squad, BAN_squad, ENG_squad, IND_squad, NZ_squad, PAK_squad, SA_squad, SL_squad, WI_squad]
var ply1_idx = 0
var ply2_idx = 1
var curr_ply_idx = ply1_idx
var my_team_idx = 0
var curr_opp_idx = 0
var score_arr_ply = []
var score_arr_opp = []
#for bowlers
var wicket_arr_ply = []
var wicket_arr_opp = []
var economy_arr_ply = []
var economy_arr_opp = []
var over_arr_opp = []
var over_arr_ply = []
var bowler_idx = 0
#var is_out_arr = []

func _ready():
	for _i in range(11):
		score_arr_opp.append(0)
		score_arr_ply.append(0)
	for _i in range(4):
		wicket_arr_opp.append(0)
		wicket_arr_ply.append(0)
		economy_arr_opp.append(0)
		economy_arr_ply.append(0)
		over_arr_opp.append(0)
		over_arr_ply.append(0)
#		is_out_arr.append(false)
	_load_squad()
	_print_scorecard()
	_choose_random_bowler()

func _print_scorecard():
	$rich_text_label.clear()
	$rich_text_label.push_table(2)
	_update_scorecard(my_team_idx,"player")
	_update_scorecard(curr_opp_idx,"opponent")
	$rich_text_label.pop()
	_print_bowler_stats("player",my_team_idx)
	_print_bowler_stats("opponent",curr_opp_idx)
	

func _load_squad(): # call this just once
	my_team_idx = get_parent().get_parent().my_idx
	curr_opp_idx = get_parent().get_parent().opp_idx

func _if_out(): # this function needs to be called before _if_over_over
#	print("_if_out_invoked")
	if curr_ply_idx < 11:
#		is_out_arr[curr_ply_idx] = true
		if curr_ply_idx == ply1_idx:
			ply1_idx = ply2_idx
		ply2_idx = ply2_idx + 1
		curr_ply_idx = ply2_idx

func _if_over_over():
#	print("_if_over_over invoked")
	if curr_ply_idx == ply1_idx:
		curr_ply_idx = ply2_idx
	else:
		curr_ply_idx = ply1_idx

func _if_runs_scored(runs,id):
#	print("_if_runs_scored invoked")
	if id == "player":
		score_arr_ply[curr_ply_idx] += runs
		if runs % 2 == 1:
			if curr_ply_idx == ply1_idx:
				curr_ply_idx = ply2_idx
			else:
				curr_ply_idx = ply1_idx
	else:
		score_arr_opp[curr_ply_idx] += runs
		if runs % 2 == 1:
			if curr_ply_idx == ply1_idx:
				curr_ply_idx = ply2_idx
			else:
				curr_ply_idx = ply1_idx

func _update_scorecard(idx,id):
	if id == "player":
		_push_pop(get_parent().my_name,$rich_text_label.ALIGN_LEFT)
		_push_pop("Runs",$rich_text_label.ALIGN_RIGHT)
		_push_pop("\n",$rich_text_label.ALIGN_LEFT)
		_push_pop("\n",$rich_text_label.ALIGN_LEFT)
		for i in range(11):
			if i == curr_ply_idx and get_parent()._player_batting:
				_push_pop("[color=#FFFF00]" + squad[idx][i] + " (*)" + "[/color]",$rich_text_label.ALIGN_LEFT)
			elif get_parent()._player_batting and (i == ply1_idx or i == ply2_idx):
				_push_pop("[color=#FFFF00]" + squad[idx][i] + "[/color]",$rich_text_label.ALIGN_LEFT)
			else:
				_push_pop(squad[idx][i],$rich_text_label.ALIGN_LEFT)
			_push_pop(score_arr_ply[i],$rich_text_label.ALIGN_RIGHT)
	else:
		_push_pop(get_parent().opp_name,$rich_text_label.ALIGN_LEFT)
		_push_pop("Runs",$rich_text_label.ALIGN_RIGHT)
		_push_pop("\n",$rich_text_label.ALIGN_LEFT)
		_push_pop("\n",$rich_text_label.ALIGN_LEFT)
		for i in range(11):
			if not get_parent()._player_batting and i == curr_ply_idx:
				_push_pop("[color=#FFFF00]" + squad[idx][i] + " (*)" + "[/color]",$rich_text_label.ALIGN_LEFT)
			elif not get_parent()._player_batting and (i == ply1_idx or i == ply2_idx):
				_push_pop("[color=#FFFF00]" + squad[idx][i] + "[/color]",$rich_text_label.ALIGN_LEFT)
			else:
				_push_pop(squad[idx][i],$rich_text_label.ALIGN_LEFT)
			_push_pop(score_arr_opp[i],$rich_text_label.ALIGN_RIGHT)
	_push_pop("\n\n\n",$rich_text_label.ALIGN_LEFT)
	_push_pop("\n\n\n",$rich_text_label.ALIGN_LEFT)

func _push_pop(val,align_var):
	$rich_text_label.push_cell()
	$rich_text_label.push_align(align_var)
	$rich_text_label.append_bbcode(str(val))
	$rich_text_label.pop()
	$rich_text_label.pop()
	
func _choose_random_bowler():
	randomize()
	var new_idx = randi()%4
	if bowler_idx == new_idx:
		if new_idx + 1 < 4:
			bowler_idx = new_idx + 1
		elif new_idx - 1 >= 0:
			bowler_idx = new_idx - 1
		else:
			print("Error: cannot decide new bowler index!")
	else:
		bowler_idx = new_idx
	
func _set_bowler_economy(id,runs):
	if id == "player":
		economy_arr_ply[bowler_idx] += runs
		over_arr_ply[bowler_idx] += 1
	else:
		economy_arr_opp[bowler_idx] += runs
		over_arr_opp[bowler_idx] += 1
	
func _set_bowler_wickets(id):
	if id == "player":
		wicket_arr_ply[bowler_idx] += 1
		over_arr_ply[bowler_idx] += 1
	else:
		wicket_arr_opp[bowler_idx] += 1
		over_arr_opp[bowler_idx] += 1
	
func _print_bowler_stats(id,idx):
#	player		overs		wickets		runs		economy
	$rich_text_label.push_table(5)
	_push_pop("Player\n",$rich_text_label.ALIGN_LEFT)
	_push_pop("  Ovr   \n",$rich_text_label.ALIGN_CENTER)
	_push_pop("W   \n",$rich_text_label.ALIGN_CENTER)
	_push_pop("Runs   \n",$rich_text_label.ALIGN_CENTER)
	_push_pop("Eco   \n",$rich_text_label.ALIGN_CENTER)
	if id == "player":
		for i in range(4):
			if i == bowler_idx and not get_parent()._player_batting:
				_push_pop("[color=#FFFF00]" + squad[idx][10-i] + "(*)" + "[/color]",$rich_text_label.ALIGN_LEFT)
			else:
				_push_pop(squad[idx][10-i],$rich_text_label.ALIGN_LEFT)
			_push_pop(str(over_arr_ply[i]/6) + "." + str(over_arr_ply[i]%6),$rich_text_label.ALIGN_CENTER)
			_push_pop(str(wicket_arr_ply[i]),$rich_text_label.ALIGN_CENTER)
			_push_pop(str(economy_arr_ply[i]),$rich_text_label.ALIGN_CENTER)
			if over_arr_ply[i] != 0:
				_push_pop(str("%0.1f"%(float(economy_arr_ply[i])*6/over_arr_ply[i])),$rich_text_label.ALIGN_CENTER)
			else:
				_push_pop(str(0),$rich_text_label.ALIGN_CENTER)
	else:
		for i in range(4):
			if i == bowler_idx and get_parent()._player_batting:
				_push_pop("[color=#FFFF00]" + squad[idx][10-i] + "(*)" + "[/color]",$rich_text_label.ALIGN_LEFT)
			else:
				_push_pop(squad[idx][10-i],$rich_text_label.ALIGN_LEFT)
			_push_pop(str(over_arr_opp[i]/6) + "." + str(over_arr_opp[i]%6),$rich_text_label.ALIGN_CENTER)
			_push_pop(str(wicket_arr_opp[i]),$rich_text_label.ALIGN_CENTER)
			_push_pop(str(economy_arr_opp[i]),$rich_text_label.ALIGN_CENTER)
			if over_arr_opp[i] != 0:
				_push_pop(str("%0.1f"%(float(economy_arr_opp[i])*6/over_arr_opp[i])),$rich_text_label.ALIGN_CENTER)
			else:
				_push_pop(str(0),$rich_text_label.ALIGN_CENTER)
	_push_pop("\n\n",$rich_text_label.ALIGN_CENTER)
	_push_pop("\n\n",$rich_text_label.ALIGN_CENTER)
	_push_pop("\n\n",$rich_text_label.ALIGN_CENTER)
	_push_pop("\n\n",$rich_text_label.ALIGN_CENTER)
	_push_pop("\n\n",$rich_text_label.ALIGN_CENTER)
	$rich_text_label.pop()
func _on_hide_pressed():
	self.visible = false
