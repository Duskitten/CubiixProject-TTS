RSRC                    VisualShader            ��'<�>                                            �      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    source    texture    texture_type    input_name    parameter_name 
   qualifier    color_default    texture_filter    texture_repeat    texture_source    op_type 	   operator 	   function    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/29/node    nodes/fragment/29/position    nodes/fragment/34/node    nodes/fragment/34/position    nodes/fragment/36/node    nodes/fragment/36/position    nodes/fragment/38/node    nodes/fragment/38/position    nodes/fragment/39/node    nodes/fragment/39/position    nodes/fragment/40/node    nodes/fragment/40/position    nodes/fragment/41/node    nodes/fragment/41/position    nodes/fragment/42/node    nodes/fragment/42/position    nodes/fragment/43/node    nodes/fragment/43/position    nodes/fragment/44/node    nodes/fragment/44/position    nodes/fragment/45/node    nodes/fragment/45/position    nodes/fragment/46/node    nodes/fragment/46/position    nodes/fragment/47/node    nodes/fragment/47/position    nodes/fragment/48/node    nodes/fragment/48/position    nodes/fragment/50/node    nodes/fragment/50/position    nodes/fragment/51/node    nodes/fragment/51/position    nodes/fragment/52/node    nodes/fragment/52/position    nodes/fragment/53/node    nodes/fragment/53/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections           local://Gradient_331bd �         local://FastNoiseLite_ixgw8 (         local://NoiseTexture2D_2pt5x �      &   local://VisualShaderNodeTexture_pgr4r �      $   local://VisualShaderNodeInput_j6d07 A      8   local://VisualShaderNodeTextureParameterTriplanar_cqvve v      '   local://VisualShaderNodeVectorOp_kvslk �      $   local://VisualShaderNodeInput_0770q �      %   local://VisualShaderNodeUVFunc_slbnr �      '   local://VisualShaderNodeVectorOp_6kbe2       )   local://VisualShaderNodeVectorFunc_l6cel �      '   local://VisualShaderNodeVectorOp_q7yrl �      '   local://VisualShaderNodeVectorOp_msnjo f      &   local://VisualShaderNodeTexture_kp86y �      $   local://VisualShaderNodeInput_6y86m +      8   local://VisualShaderNodeTextureParameterTriplanar_cmihk `      $   local://VisualShaderNodeInput_oaoyx �      %   local://VisualShaderNodeUVFunc_50bsa       '   local://VisualShaderNodeVectorOp_vc56t k      '   local://VisualShaderNodeVectorOp_gk1gs �      '   local://VisualShaderNodeVectorOp_bj6ns U      "   local://VisualShaderNodeMix_omjbs �      '   local://VisualShaderNodeVectorOp_xjlte n      R   res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Shaders/hexstaria_Light_Water.res       	   Gradient       !          ��_?   $          #�I?  l?  �?    p��>��k?  �?         FastNoiseLite             	         ?               
         �p�@                           NoiseTexture2D    !         "      �K�>&             '                     VisualShaderNodeTexture    (          ,         -                     VisualShaderNodeInput    /         uv       *   VisualShaderNodeTextureParameterTriplanar    0         TextureParameterTriplanar .         3                  VisualShaderNodeVectorOp    )                                                   ?  �?   ?*                6         7                  VisualShaderNodeInput    /         time          VisualShaderNodeUVFunc    )               
     �?  �?      
   ���=             VisualShaderNodeVectorOp    )                
                 
     �C  �C6          7                  VisualShaderNodeVectorFunc    )                
           6          8                  VisualShaderNodeVectorOp    )                
                 
   ���=���=6          7                  VisualShaderNodeVectorOp    )                
                 
   ���>���>6          7                  VisualShaderNodeTexture    (          ,         -                     VisualShaderNodeInput    /         uv       *   VisualShaderNodeTextureParameterTriplanar    0         TextureParameterTriplanar2 .         3                  VisualShaderNodeInput    /         time          VisualShaderNodeUVFunc    )               
     �?  �?      
   ���=             VisualShaderNodeVectorOp    )                
                 
     �C  �C6          7                  VisualShaderNodeVectorOp    )                
                 
   ��̽��̽6          7                  VisualShaderNodeVectorOp    )                
                 
   ���>���>6          7                  VisualShaderNodeMix    )                                              �?  �?  �?  �?            ?   ?   ?   ?*                6                  VisualShaderNodeVectorOp    )                                                   ?  �?��L?*                6         7                  VisualShader /   9      1  shader_type spatial;
render_mode blend_mix, depth_draw_never, cull_disabled, diffuse_lambert, specular_schlick_ggx;

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
// Input:44
	vec2 n_out44p0 = UV;


// VectorOp:48
	vec2 n_in48p1 = vec2(350.00000, 350.00000);
	vec2 n_out48p0 = n_out44p0 * n_in48p1;


// Input:46
	float n_out46p0 = TIME;


// VectorOp:51
	vec2 n_in51p1 = vec2(0.30000, 0.30000);
	vec2 n_out51p0 = vec2(n_out46p0) * n_in51p1;


// VectorOp:50
	vec2 n_in50p1 = vec2(-0.10000, -0.10000);
	vec2 n_out50p0 = n_out51p0 * n_in50p1;


// UVFunc:47
	vec2 n_in47p1 = vec2(1.00000, 1.00000);
	vec2 n_out47p0 = n_out50p0 * n_in47p1 + n_out48p0;


// TextureParameterTriplanar:45
	vec4 n_out45p0 = triplanar_texture(TextureParameterTriplanar2, triplanar_power_normal, triplanar_pos);


	vec4 n_out43p0;
// Texture2D:43
	n_out43p0 = texture(TextureParameterTriplanar2, n_out47p0);


// VectorOp:53
	vec4 n_in53p1 = vec4(0.00000, 0.50000, 1.00000, 0.80000);
	vec4 n_out53p0 = n_out43p0 * n_in53p1;


// Input:3
	vec2 n_out3p0 = UV;


// VectorOp:39
	vec2 n_in39p1 = vec2(400.00000, 400.00000);
	vec2 n_out39p0 = n_out3p0 * n_in39p1;


// Input:36
	float n_out36p0 = TIME;


// VectorOp:42
	vec2 n_in42p1 = vec2(0.30000, 0.30000);
	vec2 n_out42p0 = vec2(n_out36p0) * n_in42p1;


// VectorFunc:40
	vec2 n_out40p0 = sin(n_out42p0);


// VectorOp:41
	vec2 n_in41p1 = vec2(0.10000, 0.10000);
	vec2 n_out41p0 = n_out40p0 * n_in41p1;


// UVFunc:38
	vec2 n_in38p1 = vec2(1.00000, 1.00000);
	vec2 n_out38p0 = n_out41p0 * n_in38p1 + n_out39p0;


// TextureParameterTriplanar:29
	vec4 n_out29p0 = triplanar_texture(TextureParameterTriplanar, triplanar_power_normal, triplanar_pos);


	vec4 n_out2p0;
// Texture2D:2
	n_out2p0 = texture(TextureParameterTriplanar, n_out38p0);


// VectorOp:34
	vec4 n_in34p1 = vec4(0.00000, 0.50000, 1.00000, 0.50000);
	vec4 n_out34p0 = n_out2p0 * n_in34p1;


// Mix:52
	vec4 n_in52p2 = vec4(0.50000, 0.50000, 0.50000, 0.50000);
	vec4 n_out52p0 = mix(n_out53p0, n_out34p0, n_in52p2);
	float n_out52p4 = n_out52p0.a;


// Output:0
	ALBEDO = vec3(n_out52p0.xyz);
	ALPHA = n_out52p4;
	SPECULAR = n_out52p4;


}
 =         >         R   
     �D  �BT   
     zD   CU            V   
     ��  DW            X   
     ��  �BY            Z   
     ��  �C[            \   
     p�  D]            ^   
    ���  ��_            `   
     R�  �Ca         	   b   
    ���  Cc         
   d   
     /�  pBe            f   
     ��  pBg            h   
     k�    i            j   
     �  ��k            l   
    ���  R�m            n   
    ���   �o            p   
     ��  k�q            r   
     a�  �s            t   
     ��  C�u            v   
     ��  W�w            x   
     z�  f�y            z   
   �]�C�=B{            |   
     ��   �}       X                      "              '       '       &       &              (       )       )       &      $       *       *       (       -      +      ,       0       0       /       /       +       2       /      .       3       4               4             4             "       4      +       5       5       4       3       2             RSRC