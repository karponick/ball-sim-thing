extends Node2D

const ball_gen = preload("res://scenes/ball_gen.tscn")
var bg
var vp

var color_bounce = false
var color_fade = false
var speed = 2

func _ready():
	vp = get_viewport()
	vp.connect("size_changed", self, "_on_vp_size_changed")
	
	OS.max_window_size = Vector2(1920, 1080)
	bg = ball_gen.instance()
	bg.set_speed(speed)
	self.add_child(bg)
	
	
func _process(delta):
	$GUI/count.text = str(bg.get_ball_count())

func _on_vp_size_changed():
	$GUI/count.margin_top = -$GUI/count.rect_size.y
	
	$bounds/right.position = Vector2(vp.size.x + 10, vp.size.y / 2)
	$bounds/right.scale.y = vp.size.y / 10
	
	$bounds/bottom.position = Vector2(vp.size.x / 2, vp.size.y + 10)
	$bounds/bottom.scale.x = vp.size.x / 10

func clear():
	bg.queue_free()
	bg = ball_gen.instance()
	bg.set_speed(speed)
	self.add_child(bg)

func add_balls(num):
	bg.add_ball(num, color_bounce, color_fade)

func pretty():
	bg.change_colors()

func bounce_color():
	color_bounce = not color_bounce
	bg.color_bounce(color_bounce)

func fade_color():
	color_fade = not color_fade
	bg.color_fade(color_fade)

func set_speed(value):
	speed = value
	bg.set_speed(speed)
	bg.change_speeds()
