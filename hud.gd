extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_health_changed(health: int) -> void:
	$HealthText.text = 'Health: '+ str(health)


func _on_player_level_upped(level: int) -> void:
	$LevelText.text = 'Level: '+ str(level-1)
