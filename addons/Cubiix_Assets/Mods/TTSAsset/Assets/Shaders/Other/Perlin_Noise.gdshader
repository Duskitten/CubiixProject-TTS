shader_type canvas_item;

uniform vec4 ColorA : source_color;
uniform vec4 ColorB : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

vec2 randomGradient(vec2 p){
	p = p + 0.01 * TIME/10.0;
	float x = dot(p,vec2(123.4,234.5));
	float y = dot(p,vec2(234.5,345.6));
	vec2 gradient = vec2(x,y);
	gradient = sin(gradient);
	gradient = gradient * 43758.5453;

	return gradient;
}

vec2 quintic(vec2 p) {
  return p * p * p * (10.0 + p * (-15.0 + p * 6.0));
}

void fragment() {
	// Part 1
	vec2 uv = UV * 4.0;
	vec3 color = ColorA.xyz;
	vec2 gridId = floor(uv);
	vec2 gridUv = fract(uv);

	color = vec3(gridId, 0.0);
	color = vec3(gridUv, 0.0);

	//Part 2.1
	vec2 bl = gridId + vec2(0.0,0.0);
	vec2 br = gridId + vec2(1.0,0.0);
	vec2 tl = gridId + vec2(0.0,1.0);
	vec2 tr = gridId + vec2(1.0,1.0);

	//Part 2.2
	vec2 gradBl = randomGradient(bl);
	vec2 gradBr = randomGradient(br);
	vec2 gradTl = randomGradient(tl);
	vec2 gradTr = randomGradient(tr);

	//part 2.3
	vec2 distFromPixelToBl = gridUv - vec2(0.0, 0.0);
	vec2 distFromPixelToBr = gridUv - vec2(1.0, 0.0) ;
	vec2 distFromPixelToTl = gridUv - vec2(0.0, 1.0);
	vec2 distFromPixelToTr = gridUv - vec2(1.0, 1.0);

	// part 4.1 - calculate the dot products of gradients + distances
	float dotBl = dot(gradBl, distFromPixelToBl);
	float dotBr = dot(gradBr, distFromPixelToBr);
	float dotTl = dot(gradTl, distFromPixelToTl);
	float dotTr = dot(gradTr, distFromPixelToTr);

	gridUv = quintic(gridUv);

	float b = mix(dotBl, dotBr, gridUv.x);
	float t = mix(dotTl, dotTr, gridUv.x);
	float perlin = mix(b, t, gridUv.y);

	color = vec3(perlin);

	COLOR = vec4(color,1.0);

}