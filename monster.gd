extends RigidBody2D

@export var health = 5
@export var xp_on_death = 1
@export var speed = 100

@onready var nav_agent = $NavigationAgent2D  # Get NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nav_agent.target_position = PlayerTracker.player_position  # Get player position from Autoload
	$AnimatedSprite2D.play()
	
func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return  # Stop if there's no path

	var next_position = nav_agent.get_next_path_position()
	var direction = (next_position - position).normalized()
	
	position += direction * speed * delta  # Move the monster manually
