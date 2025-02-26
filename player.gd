extends Area2D

# Notifies when player health is updated
signal health_changed
#signal xp_changed
signal level_upped

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var health = 100
@export var Bullet : PackedScene
@export var xp = 0
@export var xp_levels = [10,20,30,40,50,60,70,80,90,100]
@export var attack_speed = 1
@export var piercing = 1

var screen_size # Size of the game window.

var invulnerable = false
var level = 1
var time_since_last_attack = 0.0  # Temps écoulé depuis la dernière attaque

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	health_changed.emit(health)
	#hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var attack_second = 1.0/attack_speed
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.flip_h = false
		$ProjectileSpawn.rotation = deg_to_rad(360)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.flip_h = true
		$ProjectileSpawn.rotation = deg_to_rad(180)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if time_since_last_attack > attack_second:
		shoot()
		time_since_last_attack = 0.0
	
	time_since_last_attack += delta

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	PlayerTracker.player_position = position  # Update position globally


func _on_invulnerable_timer_timeout() -> void:
	invulnerable = false
	modulate = Color(1, 1, 1, 1)
	
func update_health(new_health) -> void:
	if health > new_health:
		invulnerable = true
		modulate = Color(255, 1, 1, 0.5)
		$Invulnerable_timer.start()
	health = new_health
	health_changed.emit(health)

func shoot():
	var b = Bullet.instantiate()
	b.max_piercing = piercing
	owner.add_child(b)
	b.monster_killed.connect(_on_monster_killed)
	b.transform = $ProjectileSpawn.global_transform
	
func _on_monster_killed(xp_on_death):
	xp += xp_on_death
	#xp_changed.emit(xp):
	$AudioStreamPlayer.play()
	if(level-1 < xp_levels.size() && xp_levels[level-1] < xp):
		level+=1;
		print('levelup')
		level_upped.emit(level)

func apply_stat_upgrade(upgrade_type):
	match upgrade_type:
		"Speed Boost":
			speed += 50
		"Attack Speed Boost":
			attack_speed += 0.5
		"Piercing Boost":
			piercing += 1

func _on_body_entered(body: Node2D) -> void:
	if(invulnerable == false):
		update_health(health-10)
