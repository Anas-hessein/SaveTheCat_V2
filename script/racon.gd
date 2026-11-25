extends CharacterBody2D

class_name RacoEnemy

const speed = 30
var is_raco_chase: bool = false

var health = 50
var health_max = 50
var health_min = 0

var dead = false
var taking_damage = false
var damage_to_deal = 20
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = 200
var is_roaming: bool = true

func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0  
	move(delta)
	handle_animation()
	move_and_slide()

func move(delta):
	if !dead:
		if !is_raco_chase:
			velocity += dir * speed * delta
		is_roaming = true
	elif dead:
		velocity.x = 0 
		
func handle_animation():
	var anim_sprite = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("idle")
		if dir.x == -1:
			anim_sprite.flip_h = true
		elif dir.x == 1:
			anim_sprite.flip_h = false

func _on_dir_timer_timeout() -> void:
		$DirTimer.wait_time = choose([1.5,2.0,2.5])
		if !is_raco_chase:
			dir = choose([Vector2.RIGHT, Vector2.LEFT])
			velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()
