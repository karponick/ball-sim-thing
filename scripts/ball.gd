extends KinematicBody2D

var win_size = 400
var ball_offset
export var speed = 5
var velocity = Vector2.ONE
var sc = 0.5

var colors = [Color(1,0,0,1), Color(0,1,0,1), Color(0,0,1,1)]

func _ready():
	randomize()
	position = Vector2(200, 200)
	rotation = rand_range(0, 360)
	velocity = velocity.rotated(rotation).normalized()
#	modulate = colors[randi() % colors.size()]
	set_color()
	sc = randf() * 0.5 + 0.5
	scale = Vector2(sc, sc)
	ball_offset = sc * 16
	
func _process(delta):
	if position.x < ball_offset and velocity.x < 0:
		velocity.x *= -1
	if position.x > win_size - ball_offset and velocity.x > 0:
		velocity.x *= -1
	if position.y < ball_offset and velocity.y < 0:
		velocity.y *= -1
	if position.y > win_size - ball_offset and velocity.y > 0:
		velocity.y *= -1
	
	move2()

func get_velocity():
	return velocity

func set_speed(val):
	speed = val

func set_color():
	modulate = Color(randf(), randf(), randf())

func move1():
	position.x += velocity.x
	position.y += velocity.y
	move_and_slide(velocity * speed)
	
func move2():
	var obj = move_and_collide(velocity * speed)
	if obj:
		var a_vel = obj.get_collider().get_velocity()
		velocity.x *= a_vel.x / abs(a_vel.x)
		velocity.y *= a_vel.y / abs(a_vel.y)
