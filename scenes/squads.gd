extends Node2D

var IND_squad = [
"Row hit Sharmma",
"Sicker the van",
"V Rat K holi",
"M Es Donny",
"K Dawg Jatav",
"D Nesh Car thick",
"Hardy Pandia",
"Sir Ravi Jad-a-ja",
"Bhuvan Eeshwar Kumar",
"Yujeendra Chai halwa",
"Jaspirath Boomraah"
]

var PAK_squad = [
"Surfer Raj",
"A Bit Alle",
"Bubbar Azum",
"Fashame Ashruff",
"Fukker Zameen",
"Harees Sohale",
"Hussaan Ally",
"Im mad  Wajeem",
"Imum-ul-hack",
"Joony Khan",
"Mohmd Half ez" 
]

var ENG_squad = [
"Ion More Gant",
"Maiden Alley",
"Jo NeeBar Sto",
"Jo Spatler",
"Tommy Q Ran",
"Joi Thenly",
"Allex Inhales",
"Lia M Plumkit",
"A Dil Rashit",
"Jo Groot",
"Chris Woke"
]

var SL_squad = [
"Angel O Mathues",
"Lazyth Mallinga",
"Kushell Perara",
"Lairu Thirumunne",
"Avishikka Fernado",
"Kushell Mentos",
"Djay the Silver",
"Doosra Perara",
"Ishoe Roo Udona",
"Surango Lakkmal",
"Newvan Prat Deep"
]

var BAN_squad = [
"Mash Rough Been More Dazzle",
"Shakeep Ali Hussan",
"Tamehim Ickball",
"Leet on Kumar Dhas",
"Mustfrickher Raheem",
"Ma Mood Ulot",
"Mo Mad Mitron",
"Sabbher Raa Man",
"Meddy Mi Raze",
"Shoumy Sargaar",
"Ruby Hustain"
]

var AUS_squad = [
"A A Ron French",
"Jaisan Bedroomdoor",
"Bat Cumins",
"Ozyman K-waja",
"Not hen Lion",
"Shawn March",
"Gwenn Max swell",
"Steel Smitt",
"Michael Stork",
"Mark Cuss Stopnes",
"Da Weed Worner"
]

var NZ_squad = [
"Kain Willy",
"Tommy Blundelly",
"Trendy Bolty",
"Locky Fergoosy",
"Colly the grand homie",
"Marty Gupty",
"Matty Henroo",
"Tomy Ladhamy",
"Colly Mun Row",
"Jimmothy Neesh",
"Henroo Nik Las"
]

var WI_squad = [
"J Son Hold Her",
"Fabiano All In",
"Car Loss Breath Weight",
"Dahren Brave",
"Schelton Cottrall",
"Shameon Gaby",
"Christ Gaylo",
"Shey Hop",
"Evil Lewy",
"Keemer Rooch",
"Andro Rustel"
]

var AFG_squad = [
"Gullyboy Naib",
"Afthaab Allem",
"Ashgar Afgany",
"Dolat Zadrine",
"Hommie Huzane",
"Hashimuthalla Sheedi",
"Mujeep Ur Raheman",
"Roshit Khan",
"Rahmeet Shoh",
"Sha Mulla Shinwari",
"Noora Lee"
]

var SA_squad = [
"Far Du Plaza",
"Hashy Amle",
"Clinton De Clock",
"JP Dominick",
"Maiden Markam",
"Daveed Muller",
"Lungy NGodo",
"K Geeser Raw Bada",
"Dail Steen",
"Imrun Theheer",
"Wand her Dozen"
]
var squad = [AFG_squad, AUS_squad, BAN_squad, ENG_squad, IND_squad, NZ_squad, PAK_squad, SA_squad, SL_squad, WI_squad]
var ply1_idx = 0
var ply2_idx = 1
var curr_ply_idx = ply1_idx
var my_team_idx = 0
var curr_opp_idx = 0
var score_arr_ply = []
var score_arr_opp = []
#var is_out_arr = []

func _ready():
	for _i in range(11):
		score_arr_opp.append(0)
		score_arr_ply.append(0)
#		is_out_arr.append(false)
	_load_squad()

func _print_scorecard():
	$rich_text_label.clear()
	_update_scorecard(my_team_idx,"player")
	_update_scorecard(curr_opp_idx,"opponent")

func _load_squad(): # call this just once
	my_team_idx = get_parent().get_parent().my_idx
	curr_opp_idx = get_parent().get_parent().opp_idx

func _if_out(): # this function needs to be called before _if_over_over
	print("_if_out_invoked")
	if curr_ply_idx < 11:
#		is_out_arr[curr_ply_idx] = true
		if curr_ply_idx == ply1_idx:
			ply1_idx = ply2_idx
		ply2_idx = ply2_idx + 1
		curr_ply_idx = ply2_idx

func _if_over_over():
	print("_if_over_over invoked")
	if curr_ply_idx == ply1_idx:
		curr_ply_idx = ply2_idx
	else:
		curr_ply_idx = ply1_idx

func _if_runs_scored(runs,id):
	print("_if_runs_scored invoked")
	if id == "player":
		score_arr_ply[curr_ply_idx] += runs
	else:
		score_arr_opp[curr_ply_idx] += runs

func _update_scorecard(idx,id):
	$rich_text_label.push_table(2)
	_push_pop("Player",$rich_text_label.ALIGN_LEFT)
	_push_pop("Runs",$rich_text_label.ALIGN_RIGHT)
	if id == "player":
		for i in range(11):
			_push_pop(squad[idx][i],$rich_text_label.ALIGN_LEFT)
			_push_pop(score_arr_ply[i],$rich_text_label.ALIGN_RIGHT)
	else:
		for i in range(11):
			_push_pop(squad[idx][i],$rich_text_label.ALIGN_LEFT)
			_push_pop(score_arr_opp[i],$rich_text_label.ALIGN_RIGHT)
	$rich_text_label.pop()

func _push_pop(val,align_var):
	$rich_text_label.push_align(align_var)
	$rich_text_label.add_text(str(val))
	$rich_text_label.pop()

func _on_hide_pressed():
	self.visible = false
