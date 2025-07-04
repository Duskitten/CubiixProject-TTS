shader_type spatial;
render_mode cull_disabled;

uniform lowp float edgefade : hint_range(0, 1) = 0.2;
uniform lowp float globalfade : hint_range(0, 1) = 0.5;
//uniform sampler2D texture: source_color, filter_linear, repeat_disable;

void fragment () {
	float sinvresnel = pow(dot(normalize(NORMAL), normalize(VIEW)), (edgefade*25.0))*(1.0-globalfade);
	ALPHA = sinvresnel;
//	ALBEDO = texture(texture, UV).rgb;
}

uniform float height_scale = 0.5;
uniform float num = 0.5;
uniform sampler2D displacement;

varying vec2 tex_position;

void vertex() {
  tex_position = VERTEX.xz / 2.0 + 0.5 + TIME/num;
  float height = texture(displacement, tex_position).x;
  VERTEX.y += height * height_scale;
}