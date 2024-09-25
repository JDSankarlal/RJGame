extends Node3D

@onready var resource = "res://Dialogues/Test/lodge_test.dialogue"
@onready var title = "this_is_a_node_title"

#Ideally this input method is emitted from NPCs and objects, not kept here
func _input(event):
	if event.is_action_pressed("test_dialogue"):
		test_npc_dialogue_on(resource, title)

# Ideally this triggers when event emitted.
func test_npc_dialogue_on(resource_string, title_string):
	var balloon = load("res://addons/dialogue_manager/example_balloon/example_balloon.tscn").instantiate()
	get_tree().current_scene.add_child(balloon)
	
	
	if FileAccess.file_exists(resource_string):
		var loaded_resource = load(resource_string)
		balloon.start(loaded_resource, title_string)
	else:
		print("Dialogue file not valid")
