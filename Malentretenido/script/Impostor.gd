extends CharacterBody2D
@onready var Wordl = get_tree(). get_root(). get_node("Wordl")
@onready var Bala = load("res://escenas/bala.tscn")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const JUMP2_VELOCITY = -300.0
const MAX_AMMO = 30


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ammo = MAX_AMMO
#var balaes = preload("res://escenas/bala.tscn") 

func _ready():
	$AnimatedSprite2D.play("idle")
	shoot()

func _crunch():
	#if event is InputEventKey and event.pressed:
	#intenta quedar crunch hasta que se suelte la tecla ui_crunch
	$AnimatedSprite2D.play("crunch")
	
func _physics_process(_delta):
	
	move_and_slide()

	
	if not is_on_floor():
		velocity.y += gravity * _delta

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
		
	if not is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP2_VELOCITY

	if Input.is_action_just_pressed("ui_focus_attack") and ammo > 0:
		shoot()
		ammo -= 1
		
	if is_on_floor() and Input.is_action_just_pressed("ui_Crunch"):
		_crunch()
		
	if Input.is_action_just_pressed("ui_reload"):
		
		reload()
	
	# Función que se llama cuando el jugador presiona la tecla de disparo
func shoot(): #video de soot
	var instance = Bala. instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	Wordl.add_child.call_deferred(instance)  
	
	
	"""var mouse_position = (get_global_mouse_position() - global_position).normalized()
	# Crear una instancia de la bala
	var bullet = instance
	# Establecer la posición de la bala igual a la del jugador
	bullet.position = position
	# Establecer la dirección de la bala igual a la del jugador
	bullet.direction = mouse_position
	# Añadir la bala como hijo del nodo raíz
	get_tree().root.add_child($"../Bala")"""



func reload():
	# Aquí implementa la lógica para recargar
	# Puedes establecer la cantidad de munición al valor máximo, reproducir una animación, etc.
	ammo = MAX_AMMO
	print("Recargando...")
	
	
	
		
