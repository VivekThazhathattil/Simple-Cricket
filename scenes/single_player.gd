extends Node2D

var ins

func _ready():
	print(self.get_path())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _do_this_after_button_press():
	ins = get_node("/root/menu").new_game.instance()
	get_node("/root/menu").add_child(ins)

func _on_one_over_pressed():
	get_node("/root/menu").no_overs = 1
	_do_this_after_button_press()

func _on_five_overs_pressed():
	get_node("/root/menu").no_overs = 5
	_do_this_after_button_press()
	
func _on_10_overs_pressed():
	get_node("/root/menu").no_overs = 10
	_do_this_after_button_press()
	
func _on_20_overs_pressed():
	get_node("/root/menu").no_overs = 20
	_do_this_after_button_press()
	
func _on_Limitless_pressed():
	get_node("/root/menu").no_overs = 1000
	_do_this_after_button_press()
	
func _on_Custom_pressed():
	pass # Replace with function body.


func _on_Test_pressed():
	pass # Replace with function body.


func _on_Button_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")
