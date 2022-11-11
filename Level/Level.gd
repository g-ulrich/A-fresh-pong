extends Node2D

var pause = false
var player_score = 0
var enemy_score = 0
const ball_center = Vector2(512, 300)

func _ready():
	start_countdown()


func _on_Left_body_entered(body):
	if $TimerNewGame.is_stopped():
		$Ball.randomize_vector()
		$Ball.position = ball_center
		enemy_score += 1
		$LabelTimer.set("custom_colors/font_color", Color(200, 0, 0))
		$neg_score.play()
	start_countdown()
	
	
func _on_Right_body_entered(body):
	if $TimerNewGame.is_stopped():
		$Ball.randomize_vector()
		$Ball.position = ball_center
		player_score += 1
		$LabelTimer.set("custom_colors/font_color", Color(0, 200, 0))
		$pos_score.play()
	start_countdown()

func _process(delta):
	if Input.is_action_just_pressed('ui_select'):
		if pause:
			$Ball.speed = 600
			$Player.speed = 800   
			pause = false
		else:
			$Ball.speed = 0
			$Player.speed = 0
			pause = true
	
	$fps.text = "FPS: " + str(int(Engine.get_frames_per_second()))
	if $bg_music.playing == false:
		$bg_music.play()
	$PlayerScore.text = str(player_score)
	$EnemyScore.text = str(enemy_score)
	$LabelTimer.text = str(int($TimerNewGame.time_left + 1))


func _on_TimerNewGame_timeout():
	$Ball.show()
	get_tree().call_group('BallGroup', 'restart_ball')
	$LabelTimer.visible = false
		
	
func start_countdown():
	$Ball.hide()
	get_tree().call_group('BallGroup', 'stop_ball')
	$TimerNewGame.start()
	$LabelTimer.visible = true
