extends Node2D

@export var monster_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var monster = monster_scene.instantiate()

	# Choose a random location on Path2D.
	var monster_spawn_location = $MobPath/MobSpawnLocation
	monster_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to a random location.
	monster.position = monster_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(monster)
