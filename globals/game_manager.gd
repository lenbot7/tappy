extends Node


const GAME = preload("res://scenes/game/game.tscn")
const MAIN = preload("res://scenes/main/main.tscn")
const COMPLEX_TRANSITION = preload("res://scenes/complex_transition/complex_transition.tscn")


var next_scene: PackedScene


func add_complex() -> void:
	var ct = COMPLEX_TRANSITION.instantiate()
	add_child(ct)


func load_game_scene() -> void:
	next_scene = GAME
	add_complex()


func load_main_scene() -> void:
	next_scene = MAIN
	add_complex()
