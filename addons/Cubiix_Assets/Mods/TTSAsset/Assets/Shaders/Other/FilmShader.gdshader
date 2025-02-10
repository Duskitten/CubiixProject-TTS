shader_type canvas_item;
const float UPDATE_INTERVAL = .05;
const float STATIC_GRANULARITY = .005;

float generate_random_static (in float size, in float interval, in vec2 uv){
	float time_step = TIME - mod(TIME,interval);
	vec2 uv_step = uv - mod(uv, size);
	return fract(sin(dot(uv_step,vec2(12.0278*sin(time_step),15.0905)))*43758.5453);
}

void fragment() {
	vec3 static_plot = vec3(generate_random_static(STATIC_GRANULARITY,UPDATE_INTERVAL,UV));
	COLOR = vec4(static_plot,.025);
}