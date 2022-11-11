extends KinematicBody2D


var speed = 300
var velocity = Vector2.ZERO

func _ready():
	randomize_vector()

func _physics_process(delta):
	var collision_obj = move_and_collide(velocity * speed * delta)
	if collision_obj:
		# normal is the direction the surface ball is bouncing off of.
		velocity = velocity.bounce(collision_obj.normal)
		$hit_wall.play()
		
		
func randomize_vector():
	# randomize makes seed random
	randomize()
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-.8, .8][randi() % 2]
	

func stop_ball():
	speed = 0
	
func restart_ball():
	speed = 600
	randomize_vector()
