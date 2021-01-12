extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var level = "res://maps/map_aban_floor1.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_enter")
	pass # Replace with function body.
	
	
	
func _on_body_enter(body):
	print(body, "entered the player area")
	if body.get_meta("type") == "player":
		get_tree().change_scene(level)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
