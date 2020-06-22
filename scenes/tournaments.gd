extends Node2D
var inst = preload("res://scenes/icc.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_go_back_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")


func _on_T20_international_cup_pressed():
	$VBoxContainer.visible = false
	add_child(inst.instance())
