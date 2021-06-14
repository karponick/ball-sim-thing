extends Node2D

const ball = preload("res://scenes/ball.tscn")
var ball_count = 0
var speed
	
func add_ball(num):
	for x in num:
		var new_ball = ball.instance()
		new_ball.set_speed(speed)
		self.add_child(new_ball)
		ball_count += 1

func get_ball_count():
	return ball_count

func set_speed(val):
	speed = val
	
func change_speeds():
	for b in self.get_children():
		b.set_speed(speed)

func change_colors():
	for b in self.get_children():
		b.set_color()
