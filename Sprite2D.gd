#https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_first_script.html
#https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_player_input.html
extends Sprite2D

signal outside_viewport 

var isInside = true
var speed = 600
var angular_speed = PI/2

func  _init():
	print("Helxlo world!")

func _process(delta):
	moveAutomatically(delta)
	#moveManually(delta)
	insideViewport()
	#print(position)

func _unhandled_input(event):
	#pass
	print(event)

func insideViewport():
	var viewportRect = get_viewport_rect()
	var myRect:Rect2 = get_rect() * get_global_transform()
	var inside = viewportRect.intersects(myRect)
	#print(viewportRect, myRect, inside)
	if inside != isInside:
		outside_viewport.emit(inside)
		isInside = inside

func moveAutomatically(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
 
func moveManually(delta):
	var direction = 0
	#You can see and edit input actions in your project
	#by going to Project -> Project Settings and clicking on the Input Map tab
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	rotation += angular_speed * direction * delta
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	
	position += velocity * delta 


func _on_button_pressed():
	#pass # Replace with function body.
	set_process(not is_processing())
	
func _ready():
	var timer:Timer = get_node("Timer")
	#autocomplete not working with signals
	timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout():
	visible = not visible
