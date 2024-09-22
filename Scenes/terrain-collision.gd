extends MeshInstance3D

@export var heightmap_shape: HeightMapShape3D
@export var heightmap_texture: Texture
@onready var colShape = $StaticBody3D/CollisionShape3D

var height_min: float = 0.0
var height_max: float = 10.0
@export var chunk_size = 2.0

# Called when the node entes the scene tree for the first time.
func _ready() -> void:
	#print("Map Data Height: ", heightmap_shape.get_map_depth() , "\nMap Data Width: ", heightmap_shape.get_map_width())
	#var heightmap_texture: Texture = ResourceLoader.load("res://Assets/Textures/new_noise_texture_2d.tres")
	var heightmap_image: Image = heightmap_texture.get_image()
	heightmap_image.decompress()
	heightmap_image.convert(Image.FORMAT_RF)
	
	var data = heightmap_image.get_data().to_float32_array()
	print (data.size())

	heightmap_shape.update_map_data_from_image(heightmap_image, height_min, height_max)

	#mesh.size = Vector2(chunk_size, chunk_size)
	#var scale_ratio = chunk_size/float(heightmap_image.get_width())
	#colShape.scale = Vector3(scale_ratio,1,scale_ratio)
	#Print map data height / width. This is the number of verticies 
	
	print(heightmap_shape.map_data.size(), "\n", data.size())
	print("Map Data Depth: ", heightmap_shape.get_map_depth() , "\nMap Data Width: ", heightmap_shape.get_map_width())
	print("Min height: ", heightmap_shape.get_min_height(), "\nMax Height: ", heightmap_shape.get_max_height())
	
	#heightmap_image.resize(heightmap_image.get_width()* 0.1, heightmap_image.get_height() * 0.1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass