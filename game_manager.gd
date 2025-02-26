extends Node

@onready var player = $"/root/Main/Player"
@onready var upgrade_menu = $"/root/Main/LevelUpMenu"

func _ready():
	upgrade_menu.hide()  # Hide the menu at game start

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_level_upped(level: int) -> void:
	get_tree().paused = true  # Pause the game on level up
	upgrade_menu.show()  # Show the upgrade menu

func _on_level_up_menu_upgrade_selected(upgrade_type: String) -> void:
	player.apply_stat_upgrade(upgrade_type)  # Delegate upgrade application to the player
	get_tree().paused = false  # Unpause the game after applying upgrade
