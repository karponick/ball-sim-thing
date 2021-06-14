extends Node2D

const ball_gen = preload("res://scenes/ball_gen.tscn")
var bg

func _ready():
	bg = ball_gen.instance()
	bg.set_speed($HSlider.value)
	self.add_child(bg)
	
func _process(delta):
	$Label.text = str(bg.get_ball_count())

func _on_Timer_timeout():
	if bg.get_ball_count() < 10:
		bg.add_ball(1)
	else:
		$Timer.stop()

func _on_Button_pressed():
	bg.queue_free()
	bg = ball_gen.instance()
	bg.set_speed($HSlider.value)
	self.add_child(bg)

func _on_Button2_pressed():
	bg.add_ball(1)

func _on_Button3_pressed():
	bg.add_ball(10)

func _on_Button4_pressed():
	bg.change_colors()

func _on_HSlider_value_changed(value):
	bg.set_speed(value)
	bg.change_speeds()



