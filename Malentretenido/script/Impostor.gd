extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_AMMO = 30


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ammo = MAX_AMMO


func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	if direction != 0:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			$AnimatedSprite2D.play("idle")

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	elif not is_on_floor():
		$AnimatedSprite2D.play("jump")


	if Input.is_action_just_pressed("ui_focus_attack") and ammo > 0:
		$AnimatedSprite2D.play("shoot")
		shoot()
		ammo -= 1

	move_and_slide()

	if Input.is_action_just_pressed("ui_reload"):
		reload()

func shoot():
	# Aquí implementa la lógica para disparar
	# Por ejemplo, puedes instanciar un proyectil, hacer raycasts, etc.
	print("Disparando...")

func reload():
	# Aquí implementa la lógica para recargar
	# Puedes establecer la cantidad de munición al valor máximo, reproducir una animación, etc.
	ammo = MAX_AMMO
	print("Recargando...")
