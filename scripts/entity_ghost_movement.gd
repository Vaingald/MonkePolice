extends KinematicBody
const SPEED = 1

export onready var target = get_node("../PlayerScene")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var velocity = global_transform.origin.direction_to(target.global_transform.origin)
	move_and_collide(velocity * SPEED * _delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
