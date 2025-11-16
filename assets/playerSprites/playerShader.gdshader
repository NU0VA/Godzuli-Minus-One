shader_type canvas_item;

uniform bool whiten = false;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
		if (whiten) {
			vec3 white = vec3(1,1,1);
			vec3 whitened_texture_rgb = mix(texture_color.rgb, white, 0.6);
		}
		else {
			COLOR = texture_color;
		}
}