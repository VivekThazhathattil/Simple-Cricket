extends ItemList
var base_item_texture = preload("res://sprites/achivement_icon.png")
var achievement_unlock_arr get_parent().get_parent().read_save(0,"achievement_unlock_arr")
func _ready():
	add_item("    Win 1 match", base_item_texture)
	add_item("    Win 5 matches", base_item_texture)
	add_item("    Win 10 matches", base_item_texture)
	add_item("    Win 20 matches", base_item_texture)
	add_item("    Win 50 matches", base_item_texture)
	add_item("    Win 100 matches", base_item_texture)
	add_item("    Win 200 matches", base_item_texture)
	add_item("    Win 500 matches", base_item_texture)
	add_item("    Win 1 T5 tournament", base_item_texture)
	add_item("    Win 5 T5 tournaments", base_item_texture)
	add_item("    Win 10 T5 tournaments", base_item_texture)
	add_item("    Win 1 T10 tournament", base_item_texture)
	add_item("    Win 5 T10 tournaments", base_item_texture)
	add_item("    Win 10 T10 tournaments", base_item_texture)
	add_item("       Win 1 Cricket Champions Leagues", base_item_texture)
	add_item("       Win 5 Cricket Champions Leagues", base_item_texture)
	add_item("       Win 10 Cricket Champions Leagues", base_item_texture)
	
	var color_arr = [
	Color(0.702448,0.229804,0.652897),
	Color(0.097445,0.418916,0.909413),
	Color(0.753771,0.409525,0.22978),
	Color(0.225164,0.857846,0.429049),
	Color(0.470671,0.012836,0.116202),
	Color(0.521036,0.870764,0.749683),
	Color(0.204935,0.170886,0.888211),
	Color(0.222149,0.033831,0.409934),
	Color(0.74365,0.291946,0.232442),
	Color(0.85135,0.162995,0.509573),
	Color(0.830744,0.339807,0.868575),
	Color(0.129416,0.251658,0.46026),
	Color(0.512893,0.602477,0.365851),
	Color(0.593735,0.376067,0.204375),
	Color(0.127104,0.318405,0.317681),
	Color(0.876025,0.980799,0.555289),
	Color(0.285167,0.820679,0.231443)
	]
	for i in range(get_item_count()):
		if achievement_unlock_arr[i] == 0:
			set_item_icon_modulate (i, Color("#48494b"))
		else:
			set_item_icon_modulate (i, color_arr[i])
