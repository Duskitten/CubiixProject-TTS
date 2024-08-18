shader_type spatial;
render_mode blend_mix;
//render_mode unshaded;

uniform sampler2D text : hint_default_white, filter_nearest;
uniform sampler2D normal_map : hint_default_white;
uniform vec4 color : source_color;
uniform bool useTexture = true;
uniform bool useNormalMap = false;
uniform float amount_of_light : hint_range(0.0,1.0);
uniform float amount_of_shadow : hint_range(0.0,1.0);
uniform float cut_point : hint_range(0.0, 1.0);
uniform float normalMapDepth;
uniform float debanding_dither;

const vec3 noise_magic = vec3(0.06711056, 0.00583715, 52.9829189);

void fragment()
{
	if(useTexture)
	{
		vec3 a1 = texture(text, UV).rgb;
		ALBEDO = a1*color.rgb;
	} else
	{
		ALBEDO = color.rgb;
	}
	if(useNormalMap == true)
	{
		vec3 normalmap = texture(normal_map, UV).xyz * vec3(2.0,2.0,2.0) - vec3(0.45,0.45,0.45);
		//vec3 normalmap = texture(normal_map, UV).xyz * vec3(2.0,2.0,2.0) - vec3(1.0,1.0,1.0);
		vec3 normal = normalize(TANGENT * normalmap.y + BINORMAL * normalmap.x + NORMAL * normalmap.z);
		NORMAL = normal;
	} else
	{
		NORMAL_MAP_DEPTH = 0.0;
	}

	float offset = fract(noise_magic.z * fract(dot(FRAGCOORD.xy, noise_magic.xy)));
	ALBEDO += vec3(offset, 1.0 - offset, offset) * debanding_dither;
}
float calc_NdotL(vec3 light, vec3 normal)
{
	float NdotL = dot(normalize(light), normal);
	return NdotL;
}
float calc_toonStripes(float NdotL)
{
	if(NdotL > cut_point)
	{
		return amount_of_light;
	}
	else if (NdotL > cut_point/1.5){
		return amount_of_light * 0.1;
	}
	else
	{
		//return NdotL * 0.03;
		return amount_of_shadow;
	}
}
void light()
{
	float NdotL = calc_NdotL(LIGHT, NORMAL);
	float intensity = calc_toonStripes(NdotL);
	float clampedAttenuation = clamp(ATTENUATION, amount_of_shadow, amount_of_light);
	DIFFUSE_LIGHT += ALBEDO*intensity* clampedAttenuation * LIGHT_COLOR * 2.0f;
//	if(useNormalMap == true)
//	{
//		DIFFUSE_LIGHT += ALBEDO*intensity*ATTENUATION * LIGHT_COLOR;
//
//	} else
//	{
//		DIFFUSE_LIGHT += ALBEDO*intensity*ATTENUATION * LIGHT_COLOR;
//	}
}
