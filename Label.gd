extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = get_node("GodotSprite")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sprite_2d_outside_viewport(value:bool):
	visible = value
