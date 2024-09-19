extends CanvasLayer

# Look up 2 nodes in hierarchy.
@onready var world = $"../"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	get_tree().quit()


func _on_resume_pressed():
	print("HERE")
	world.pauseMenu()


func _on_resume_mouse_entered():
	print("HERE2")
