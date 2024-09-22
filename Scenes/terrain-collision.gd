extends MeshInstance3D

@onready var colShape = $StaticBody3D/CollisionShape3D

@export var chunk_size = 100.0
@export var height_ratio = 14.0
@export var colshape_size_ratio = 0.1

var img = Image.new()
var shape = HeightMapShape3D.new()

# OLD VARIABLES HERE
#@export var heightmap_shape: HeightMapShape3D
#@export var heightmap_texture: Texture
#var height_min: float = 0.0
#var height_max: float = 10.0

func _ready():
	colShape.shape = shape
	mesh.size = Vector2(chunk_size, chunk_size)
	update_terrain(height_ratio, colshape_size_ratio)

func update_terrain(_height_ratio, _colshape_size_ratio):
	material_override.set("shader_param/height_ratio", _height_ratio)
	
	# Import the heightmap image. Convert the format and resize it.
	img.load("res://Assets/Textures/45_750_-78_511_13_512_512.png")
	img.convert(Image.FORMAT_RF)
	print(img.get_width())
	img.resize(img.get_width()*colshape_size_ratio, img.get_height()*colshape_size_ratio)
	
	# Set data = the image pixel data in an array format
	var data = img.get_data().to_float32_array()
	
	# Loop through the data and multiply "verticy" values by height ratio
	for i in range(0, data.size()):
		data[i] *= _height_ratio
	
	
	shape.map_width = img.get_width()
	shape.map_depth = img.get_height()
	shape.map_data = data
		
		
	var scale_ratio = chunk_size/float(img.get_width())
	colShape.scale = Vector3(scale_ratio, 1, scale_ratio)
	
	
	
	
	
	# OLD CODE HERE. WE CAN PROBABLY DELETE IT.
	#colShape.shape = shape
# Called when the node entes the scene tree for the first time.
#func _ready() -> void:
	##print("Map Data Height: ", heightmap_shape.get_map_depth() , "\nMap Data Width: ", heightmap_shape.get_map_width())
	##var heightmap_texture: Texture = ResourceLoader.load("res://Assets/Textures/new_noise_texture_2d.tres")
	#var heightmap_image: Image = heightmap_texture.get_image()
	#heightmap_image.decompress()
	#heightmap_image.convert(Image.FORMAT_RF)
	#
	#var data = heightmap_image.get_data().to_float32_array()
	#print (data.size())
#
	#heightmap_shape.update_map_data_from_image(heightmap_image, height_min, height_max)
#
	##mesh.size = Vector2(chunk_size, chunk_size)
	##var scale_ratio = chunk_size/float(heightmap_image.get_width())
	##colShape.scale = Vector3(scale_ratio,1,scale_ratio)
	##Print map data height / width. This is the number of verticies 
	#
	#print(heightmap_shape.map_data.size(), "\n", data.size())
	#print("Map Data Depth: ", heightmap_shape.get_map_depth() , "\nMap Data Width: ", heightmap_shape.get_map_width())
	#print("Min height: ", heightmap_shape.get_min_height(), "\nMax Height: ", heightmap_shape.get_max_height())
	#
	##heightmap_image.resize(heightmap_image.get_width()* 0.1, heightmap_image.get_height() * 0.1)
	#pass # Replace with function body.

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
