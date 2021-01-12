extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_enter")
	connect("body_exited", self, "_on_body_exit")

func _on_body_enter(body):
	print(body, "entered the player area")
	if body.get_meta("type") == "player":
		player = body
		body.get_node("Control/pickitemtext").visible = true
		
func _on_body_exit(body):
	if(player != null):
		player.get_node("Control/pickitemtext").visible = false

func _input(event):
	if (Input.is_action_pressed("use")):
		if (Input.MOUSE_MODE_CAPTURED):
			queue_free()
			get_parent().remove_and_skip()
			get_parent().remove_child(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
