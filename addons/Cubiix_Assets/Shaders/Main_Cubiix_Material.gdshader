shader_type spatial;
render_mode blend_mix, depth_draw_always, cull_disabled, diffuse_lambert, depth_prepass_alpha;

uniform sampler2D texture_albedo : source_color, filter_nearest, repeat_enable;

uniform vec4 Body_SourceColor[256] : source_color;
uniform vec4 Body_Color[256] : source_color;
uniform vec4 Body_Emission[256] : source_color;
uniform float Body_Metallic[256];
uniform float Body_Roughness[256];
uniform float Body_Emission_Str[256];
uniform float Body_Alpha[256];
uniform int Total = 1;

const float EPSILON = 0.0001;

bool colorMatch(vec3 c1, vec4 c2, float maxDiff) {
    return (
        abs(c1.r - c2.r) < maxDiff
        && abs(c1.g - c2.g) < maxDiff
        && abs(c1.b - c2.b) < maxDiff
    );
}

void fragment() {
	vec4 albedo_tex = texture(texture_albedo, UV);
	vec3 currentcolor = vec3(0.0,0.0,0.0);
	vec3 currentemiss = vec3(0.0,0.0,0.0);
	float currentmetallic = 0.0;
	float currentroughness = 1.0;
	float currentemissstr = 0.0;
	float currentalpha = 1.0;
	bool OK = false;
	for (int i = 0; i < Total; i++) {
		if (colorMatch(Body_SourceColor[i].rgb, albedo_tex,0.01)){
			currentcolor = Body_Color[i].rgb;
			currentemiss = Body_Emission[i].rgb;
			currentmetallic = Body_Metallic[i];
			currentroughness = Body_Roughness[i];
			currentemissstr = Body_Emission_Str[i];
			currentalpha = Body_Alpha[i];
			break;
		}
	}

	ALBEDO = currentcolor;
	EMISSION = currentemiss * currentemissstr;
	METALLIC = currentmetallic;
	ROUGHNESS = currentroughness;
	ALPHA = currentalpha;
}
