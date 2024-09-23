extends CharacterBody3D

# How fast the player moves in meters per second.
#@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
#@export var fall_acceleration = 75

signal changed_movement_state(_movement_state: PlayerMovementState)
signal changed_movement_direction(_movement_direction: Vector3)

@export var movement_states : Dictionary

var movement_direction : Vector3
var current_movement_state_name : String

func _ready():
	changed_movement_state.emit(movement_states["idle"])



func _input(event):
	if event.is_action_pressed("movement") or event.is_action_released("movement"):
		movement_direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		movement_direction.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		
		if is_movement_ongoing():
			if Input.is_action_pressed("run"):
				set_movement_state("run")
				#
				#if current_stance_name == "stealth":
					#set_stance("upright")
			else:
				set_movement_state("walk")
				#if Input.is_action_pressed("walk"):
				#else:
					#set_movement_state("run")
		else:
			set_movement_state("idle")
	
	#if event.is_action_pressed("jump"):
		#if air_jump_counter <= max_air_jump:
			#if is_stance_blocked("upright"):
				#return
			#
			#if current_stance_name != "upright" and current_stance_name != "stealth":
				#set_stance("upright")
				#return
			#
			#var jump_name = "ground_jump"
			#
			#if air_jump_counter > 0:
				#jump_name = "air_jump"
			#
			#pressed_jump.emit(jump_states[jump_name])
			#air_jump_counter += 1
	#
	#if is_on_floor():
		#for stance in stances.keys():
			#if event.is_action_pressed(stance):
				#set_stance(stance)


func _physics_process(delta):
	if is_movement_ongoing():
		changed_movement_direction.emit(movement_direction)
		
	#if is_on_floor():
		#air_jump_counter = 0
	#elif air_jump_counter == 0:
		#air_jump_counter = 1


func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0


func set_movement_state(state : String):
	#var stance = get_node(stances[current_stance_name])
	current_movement_state_name = state
	print (movement_states["idle"])
	changed_movement_state.emit(movement_states[state])


#func set_stance(_stance_name : String):
	##if stance_antispam_timer.time_left > 0:
		##return
	#stance_antispam_timer = get_tree().create_timer(0.25)
	#
	#var next_stance_name : String
	#
	#if _stance_name == current_stance_name:
		#next_stance_name = "upright"
	#else:
		#next_stance_name = _stance_name
	#
	#if is_stance_blocked(next_stance_name):
		#return
	#
	#var current_stance = get_node(stances[current_stance_name])
	#current_stance.collider.disabled = true
	#
	#current_stance_name = next_stance_name
	#current_stance = get_node(stances[current_stance_name])
	#current_stance.collider.disabled = false
	#
	#changed_stance.emit(current_stance)
	#set_movement_state(current_movement_state_name)


#func is_stance_blocked(_stance_name : String) -> bool:
	#var stance = get_node(stances[_stance_name])
	#return stance.is_blocked()











# OLD
#var target_velocity = Vector3.ZERO
#
#
#func _physics_process(delta):
	#var direction = Vector3.ZERO
#
	#if Input.is_action_pressed("move_right"):
		#direction.x += 1
	#if Input.is_action_pressed("move_left"):
		#direction.x -= 1
	#if Input.is_action_pressed("move_back"):
		#direction.z += 1
	#if Input.is_action_pressed("move_forward"):
		#direction.z -= 1
#
	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		##$Pivot.basis = Basis.looking_at(direction)
#
	## Ground Velocity
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed
#
	## Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		#target_velocity.y = target_velocity.y - (fall_acceleration * delta)
#
	## Moving the Character
	#velocity = target_velocity
	#move_and_slide()
