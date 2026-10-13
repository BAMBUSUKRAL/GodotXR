extends CharacterBody3D

@onready var neck := $neck
@onready var camera := $neck/Camera3D
@onready var cam = $neck/Camera3D
@export var speed: float = 30
@export var jump_velocity: float = 12.0
@export var gravity: float = 20.0





func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	# --- pohyb podle směru kamery ---
	var input_dir = Vector3.ZERO

	var forward = -camera.global_transform.basis.z
	var right   =  camera.global_transform.basis.x
	
	
	
	
	if Input.is_action_just_pressed("kill"):
		$"../".exit_game(name.to_int())
		get_tree().quit()
		
	if Input.is_action_pressed("forward"):
		input_dir += forward
	if Input.is_action_pressed("backward"):
		input_dir -= forward
	if Input.is_action_pressed("left"):
		input_dir -= right
	if Input.is_action_pressed("right"):
		input_dir += right

	input_dir.y = 0
	input_dir = input_dir.normalized()

	# horizontální rychlost
	var horizontal_vel = input_dir * speed
	velocity.x = horizontal_vel.x
	velocity.z = horizontal_vel.z

	# --- skok jako v oficiálním templatu ---
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
		
		

		
	move_and_slide()


   



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("exit"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.005)
			camera.rotate_x(-event.relative.y * 0.005)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
			
