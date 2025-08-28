extends Control


const GAME_OVER = preload("res://assets/audio/game_over.wav")


@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var press_space_label: Label = $PressSpaceLabel
@onready var game_over_label: Label = $GameOverLabel
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound


var _score: int = 0


func _ready() -> void:
	_score = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()
	elif press_space_label.visible and event.is_action_pressed("jump"):
		GameManager.load_main_scene()


func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)
	SignalHub.on_point_scored.connect(on_point_scored)


func on_plane_died() -> void:
	game_over_label.show()
	timer.start()
	ScoreManager.high_score = _score
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()


func _on_timer_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()


func on_point_scored() -> void:
	sound.play()
	_score += 1
	score_label.text = "%04d" % _score
