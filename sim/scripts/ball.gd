extends KinematicBody2D

var speed = 5
var velocity = Vector2.ONE
var min_scale = 0.8
var max_scale = 1.6

var color_bounce = false
var color_fade = false
var fade_speed = 0.01
var color_factor = 2

var target_hue
var vp

func _ready():
	randomize()
	vp = get_viewport()
	position = Vector2(rand_range(0, vp.size.x), rand_range(0, vp.size.y))
	rotation = rand_range(0, 360)
	velocity = velocity.rotated(rotation).normalized()
	
	set_new_color()
	target_hue = randf() * color_factor
	
	var ball_scale = randf() * (max_scale - 1) + min_scale
	scale = Vector2(ball_scale, ball_scale)
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * speed)
	if collision:
		bounce_ball(collision)
		if color_bounce:
			set_new_color()
	
	position.x = clamp(position.x, 0, vp.size.x)
	position.y = clamp(position.y, 0, vp.size.y)
	if color_fade:
		fade_ball()

func get_velocity():
	return velocity

func set_speed(val):
	speed = val

func set_color_bounce(val):
	color_bounce = val
	
func set_color_fade(val):
	color_fade = val
	
func set_new_color():
	modulate = generate_random_color()
	
func generate_random_color():
	return Color.from_hsv(randf() * color_factor, 1, 1)
	
func bounce_ball(collision):
	"""Reference: https://godotlearn.com/godot-3-1-how-to-move-objects/"""
	look_at(collision.position + -collision.normal)
	var reflect = collision.remainder.bounce(collision.normal)
	velocity = velocity.bounce(collision.normal)
	move_and_collide(reflect)

func fade_ball():
	if not hue_is_close(modulate.h, target_hue):
		modulate.h = lerp(modulate.h, target_hue, fade_speed)
	else:
		target_hue = randf() * color_factor

func hue_is_close(a, b):
	if abs(a-b) < 0.1:
		return true
	return false
	
	
