shader_type canvas_item;

uniform bool enable = false;

uniform sampler2D dissolve_texture;
uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (enable) {
		COLOR.rgb = vec3(1, 1, 1);
	} else {
	//	if (inverted) {
	//		sample = 1.0 - sample;
	//	}
		if (COLOR.a > 0.0) {
			float sample = texture(dissolve_texture, UV).r;
			COLOR.a = step(sample, dissolve_amount);
		}
//		COLOR.rgb = texture(TEXTURE, UV);
	}
	

}
