shader_type spatial;

uniform sampler2D heightmap;
uniform float heightmap_intensity = 1.0;

void vertex() {
	VERTEX.y += texture(heightmap,UV).r * (heightmap_intensity* texture(heightmap,UV).r) ;
}

void fragment() {
	ALBEDO = vec3(.25,.25,.25);
	SPECULAR = 0.0;
	ROUGHNESS = 1.0;
	METALLIC = 0.0;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
