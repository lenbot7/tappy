extends Node2D


const PIPES = preload("res://scenes/pipes/pipes.tscn")


@onready var pipes_holder: Node = $PipesHolder
@onready var upper_point: Marker2D = $UpperPoint
@onready var lower_point: Marker2D = $LowerPoint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_pipes()


func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)



func spawn_pipes() -> void:
	var new_pipe = PIPES.instantiate()
	var y_pos: float = randf_range(upper_point.position.y, lower_point.position.y)
	new_pipe.position = Vector2(upper_point.position.x, y_pos)
	pipes_holder.add_child(new_pipe)


func _on_spawn_timer_timeout() -> void:
	spawn_pipes()


func _on_plane_died() -> void:
	get_tree().paused = true
