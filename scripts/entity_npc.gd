extends KinematicBody

const SPEED = 2

var gravity = -20
var rng = RandomNumberGenerator.new()
onready var targetx = 0
onready var targetz = 0
onready var target = transform.origin * Vector3(targetx, 0, targetz)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var AnimPlayer = get_node("../AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	AnimPlayer.play("default")
	pass # Replace with function body.
func _physics_process(delta):
	var velocity = global_transform.origin.direction_to(Vector3(target))
	velocity.y = gravity * delta
	move_and_collide(velocity * SPEED * delta)
	#pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	rng.randomize()
	if (rng.randi_range(0, 1) == 0): #Randomly stand still
		AnimPlayer.stop(true)
	else:
		AnimPlayer.play("default")
	rng.randomize()
	targetx = rng.randf_range(-100.0, 100.0)
	rng.randomize()
	targetz = rng.randf_range(-100.0, 100.0)
	target = transform.origin * Vector3(targetx, 0, targetz)
