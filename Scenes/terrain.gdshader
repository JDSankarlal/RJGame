shader_type spatial;

uniform sampler2D heightmap;
uniform float height_ratio = 1.0;
uniform sampler2D _a;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y+=texture(heightmap, UV).r * height_ratio;


}

void fragment() {
	ALBEDO = texture (_a, UV).rgb;
	// Called for every pixel the material is visible on.
}


//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
