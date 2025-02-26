extends CanvasLayer

signal upgrade_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_upgrade_1_button_pressed() -> void:
	print('aaaa')
	upgrade_selected.emit("Speed Boost")
	hide_menu()


func _on_upgrade_2_button_pressed() -> void:
	print('bbbb')
	upgrade_selected.emit("Attack Speed Boost")
	hide_menu()
	
func _on_upgrade_3_button_pressed() -> void:
	print('cccc')
	upgrade_selected.emit("Piercing Boost")
	hide_menu()
	
func hide_menu():
	self.hide()
