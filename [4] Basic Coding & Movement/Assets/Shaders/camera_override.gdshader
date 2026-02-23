shader_type spatial;
render_mode unshaded, depth_test_disabled, cull_disabled;

uniform float zNear = 1.0;
uniform float zFar = 18.0; 
uniform float max_dist = 200.0; //range that you ACTUALLY care about (usually < 200). compared to what camera's 'far' value is, this max_dist is prob WAY lower, and important for making the range of values actually make sense
uniform vec4 effectColor : source_color = vec4(1.0); 

uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;

void vertex() {
	POSITION = vec4(VERTEX.xy, 0.0, 1.0);
}

float _linearizeScale(vec4 view){
	float linearDepth = vec3((view.xyz / view.w)).z;
	float depthScaled =  2.0 * (zNear * zFar) / (zFar + (linearDepth * zNear));
	return depthScaled;
}

void fragment() {
	float depthSample = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depthSample);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	
	float depthScaled = _linearizeScale(view);
	float gradient = clamp(depthScaled / max_dist, 0.0, 1.0);
	
	ALBEDO = vec3(gradient) * effectColor.rgb;
}