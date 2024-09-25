extends CharacterBody3D

signal changed_movement_state(_movement_state: PlayerMovementState)
signal changed_movement_direction(_movement_direction: Vector3)

@export var movement_states : Dictionary

var movement_direction : Vector3
var current_movement_state_name : String

func _ready():
	changed_movement_direction.emit(Vector3.BACK)
	changed_movement_state.emit(movement_states["idle"])


func _input(event):
	# Movement is wasd or shift. That is then broken down into move_right, move_left, etc.
	if event.is_action_pressed("movement") or event.is_action_released("movement"):
		movement_direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		movement_direction.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		
		# Figure out the state of the movement.
		if is_movement_ongoing():
			if Input.is_action_pressed("run"):
				set_movement_state("run")
			else:
				set_movement_state("walk")
		else:
			set_movement_state("idle")
	
	# Jump functionality if we ever need it.
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
	
	# Jump functionality if we ever need it.
	#if is_on_floor():
		#air_jump_counter = 0
	#elif air_jump_counter == 0:
		#air_jump_counter = 1


func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0


func set_movement_state(state : String):
	current_movement_state_name = state
	changed_movement_state.emit(movement_states[state])
