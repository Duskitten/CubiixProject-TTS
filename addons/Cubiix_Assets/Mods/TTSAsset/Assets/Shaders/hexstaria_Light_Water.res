RSRC                    VisualShader            ��'<�>                                            �      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    source    texture    texture_type    input_name    op_type 	   operator    parameter_name 
   qualifier    color_default    texture_filter    texture_repeat    texture_source    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/23/node    nodes/fragment/23/position    nodes/fragment/24/node    nodes/fragment/24/position    nodes/fragment/26/node    nodes/fragment/26/position    nodes/fragment/27/node    nodes/fragment/27/position    nodes/fragment/28/node    nodes/fragment/28/position    nodes/fragment/29/node    nodes/fragment/29/position    nodes/fragment/30/node    nodes/fragment/30/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections           local://Gradient_331bd �         local://FastNoiseLite_ixgw8          local://NoiseTexture2D_2pt5x �      &   local://VisualShaderNodeTexture_pgr4r �      $   local://VisualShaderNodeInput_j6d07 3      '   local://VisualShaderNodeVectorOp_jy4u1 h      $   local://VisualShaderNodeInput_62h6t �      '   local://VisualShaderNodeVectorOp_f0rwo       ,   local://VisualShaderNodeVectorCompose_mcigb 9      '   local://VisualShaderNodeVectorOp_4e6vs g      $   local://VisualShaderNodeInput_odyvi �      '   local://VisualShaderNodeVectorOp_2qny2       ,   local://VisualShaderNodeVectorCompose_2i7m6 D         local://FastNoiseLite_t2oll r         local://NoiseTexture2D_q7o4d �      &   local://VisualShaderNodeTexture_p1yio G      '   local://VisualShaderNodeVectorOp_w0ds7 �      '   local://VisualShaderNodeVectorOp_m11x3       '   local://VisualShaderNodeVectorOp_pqsuu �      1   local://VisualShaderNodeTexture2DParameter_t0lok �      1   local://VisualShaderNodeTexture2DParameter_judnm e      "   local://VisualShaderNodeMix_tjstu �      8   local://VisualShaderNodeTextureParameterTriplanar_cqvve �      8   local://VisualShaderNodeTextureParameterTriplanar_ufv7w �      R   res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Shaders/hexstaria_Light_Water.res q      	   Gradient       !          ��_?   $          #�I?  l?  �?    p��>��k?  �?         FastNoiseLite             	         ?               
         �p�@                           NoiseTexture2D    !         "      �K�>&             '                     VisualShaderNodeTexture    (          ,         -                     VisualShaderNodeInput    /         uv          VisualShaderNodeVectorOp    )                     HB  HB                         1                  VisualShaderNodeInput    /         time          VisualShaderNodeVectorOp             VisualShaderNodeVectorCompose             VisualShaderNodeVectorOp    )                     HB  HB                         1                  VisualShaderNodeInput    /         time          VisualShaderNodeVectorOp    (                   VisualShaderNodeVectorCompose             FastNoiseLite 	                  8���	         ?               
         �p�@                           NoiseTexture2D    !         "      �K�>&             '                     VisualShaderNodeTexture    ,         -                     VisualShaderNodeVectorOp    )                                                            0         1                  VisualShaderNodeVectorOp    )                
                 
     C  C0          1                  VisualShaderNodeVectorOp    )                
                 
     �B  �B0          1               #   VisualShaderNodeTexture2DParameter    2         Noise_1 .         4         5               #   VisualShaderNodeTexture2DParameter    2         Noise_2 4         5         6                  VisualShaderNodeMix    (          )                                              �?  �?  �?  �?            ?   ?   ?   ?*                0               *   VisualShaderNodeTextureParameterTriplanar    2         TextureParameterTriplanar .         5               *   VisualShaderNodeTextureParameterTriplanar    2         TextureParameterTriplanar2 .         5                  VisualShader -   8        shader_type spatial;
render_mode blend_mix, depth_draw_always, cull_disabled, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D TextureParameterTriplanar2 : source_color, filter_nearest;
uniform sampler2D TextureParameterTriplanar : source_color, filter_nearest;


// TextureParameterTriplanar
	vec4 triplanar_texture(sampler2D p_sampler, vec3 p_weights, vec3 p_triplanar_pos) {
		vec4 samp = vec4(0.0);
		samp += texture(p_sampler, p_triplanar_pos.xy) * p_weights.z;
		samp += texture(p_sampler, p_triplanar_pos.xz) * p_weights.y;
		samp += texture(p_sampler, p_triplanar_pos.zy * vec2(-1.0, 1.0)) * p_weights.x;
		return samp;
	}

	uniform vec3 triplanar_scale = vec3(1.0, 1.0, 1.0);
	uniform vec3 triplanar_offset;
	uniform float triplanar_sharpness = 0.5;

	varying vec3 triplanar_power_normal;
	varying vec3 triplanar_pos;

void vertex() {
// TextureParameterTriplanar
	{
		triplanar_power_normal = pow(abs(NORMAL), vec3(triplanar_sharpness));
		triplanar_power_normal /= dot(triplanar_power_normal, vec3(1.0));
		triplanar_pos = VERTEX * triplanar_scale + triplanar_offset;
		triplanar_pos *= vec3(1.0, -1.0, 1.0);
	}
}

void fragment() {
// Input:11
	float n_out11p0 = TIME;


// VectorCompose:13
	float n_in13p0 = 0.00000;
	float n_in13p2 = 0.00000;
	vec3 n_out13p0 = vec3(n_in13p0, n_out11p0, n_in13p2);


// VectorOp:23
	vec2 n_in23p1 = vec2(150.00000, 150.00000);
	vec2 n_out23p0 = vec2(n_out13p0.xy) / n_in23p1;


// Input:3
	vec2 n_out3p0 = UV;


// VectorOp:10
	vec3 n_in10p0 = vec3(50.00000, 50.00000, 0.00000);
	vec3 n_out10p0 = n_in10p0 * vec3(n_out3p0, 0.0);


// VectorOp:12
	vec3 n_out12p0 = vec3(n_out23p0, 0.0) + n_out10p0;


// TextureParameterTriplanar:30
	vec4 n_out30p0 = triplanar_texture(TextureParameterTriplanar2, triplanar_power_normal, triplanar_pos);


	vec4 n_out15p0;
// Texture2D:15
	n_out15p0 = texture(TextureParameterTriplanar2, vec2(n_out12p0.xy));


// Input:5
	float n_out5p0 = TIME;


// VectorCompose:7
	float n_in7p1 = 0.00000;
	float n_in7p2 = 0.00000;
	vec3 n_out7p0 = vec3(n_out5p0, n_in7p1, n_in7p2);


// VectorOp:24
	vec2 n_in24p1 = vec2(100.00000, 100.00000);
	vec2 n_out24p0 = vec2(n_out7p0.xy) / n_in24p1;


// VectorOp:4
	vec3 n_in4p0 = vec3(50.00000, 50.00000, 0.00000);
	vec3 n_out4p0 = n_in4p0 * vec3(n_out3p0, 0.0);


// VectorOp:6
	vec3 n_out6p0 = vec3(n_out24p0, 0.0) + n_out4p0;


// TextureParameterTriplanar:29
	vec4 n_out29p0 = triplanar_texture(TextureParameterTriplanar, triplanar_power_normal, triplanar_pos);


	vec4 n_out2p0;
// Texture2D:2
	n_out2p0 = texture(TextureParameterTriplanar, vec2(n_out6p0.xy));


// Mix:28
	vec4 n_in28p2 = vec4(0.50000, 0.50000, 0.50000, 0.50000);
	vec4 n_out28p0 = mix(n_out15p0, n_out2p0, n_in28p2);
	float n_out28p4 = n_out28p0.a;


// Output:0
	ALBEDO = vec3(n_out28p0.xyz);
	ALPHA = n_out28p4;
	SPECULAR = n_out28p0.x;


}
 <         =         Q   
     �D  �BS   
     zD   CT            U   
     ��  DV            W   
     ��  �BX            Y   
     C�   CZ            [   
    ���   �\            ]   
     ��  ��^            _   
     f�  p�`         	   a   
     p�  4�b         
   c   
     �  ��d            e   
      D  �f            g   
     ��  �h            i   
     �C  \�j            k   
     �A  Cl            m   
     �C  �n            o   
     �  ��p            q   
     C�  Dr            s   
     pB  ��t            u   
     �A  �Cv            w   
     ��  �Cx            y   
     p�  �z       T                                                         
                                                                                                                                                 
                                                                                          RSRC