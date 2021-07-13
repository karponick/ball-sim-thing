extends CanvasLayer

var parent
var vp

func _ready():
	parent = get_parent()
	vp = get_viewport()
	
	$clear.connect("pressed", self, "_clear_pressed")
	$add_one.connect("pressed", self, "_add_one_pressed")
	$add_ten.connect("pressed", self, "_add_ten_pressed")
	$pretty.connect("pressed", self, "_pretty_pressed")
	$bounce.connect("pressed", self, "_bounce_pressed")
	$fade.connect("pressed", self, "_fade_pressed")
	$speed.connect("value_changed", self, "_speed_changed")
	
	$count.margin_top = -$count.rect_size.y
	$bounce.modulate = Color.red
	$fade.modulate = Color.red

func _clear_pressed():
	parent.clear()
func _add_one_pressed():
	parent.add_balls(1)
func _add_ten_pressed():
	parent.add_balls(10)
func _pretty_pressed():
	parent.pretty()
func _bounce_pressed():
	parent.bounce_color()
	$bounce.modulate = $bounce.modulate.inverted()
func _fade_pressed():
	parent.fade_color()
	$fade.modulate = $fade.modulate.inverted()
func _speed_changed(value):
	parent.set_speed(value)
