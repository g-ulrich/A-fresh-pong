extends KinematicBody2D

var speed = 400

var ball

func _ready():
	ball = get_parent().find_node("Ball")

func _process(delta):
	position.x = 1004
	
func _physics_process(delta):
	move_and_slide(Vector2(0, get_enemy_direction()) * speed)
	
func get_enemy_direction():
	if abs(ball.position.y - position.y) > 25:
		if ball.position.y > position.y:
			return 1
		else:
			return -1
	else:
		return 0
