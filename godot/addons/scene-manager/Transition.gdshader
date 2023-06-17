//shader_type canvas_item;
//render_mode unshaded;
//
//uniform float cutoff : hint_range(0.0, 1.0);
//uniform float smooth_size : hint_range(0.0, 1.0);
//uniform sampler2D mask : source_color;
//uniform bool inverted = false;
//
//
//void fragment() {
//	float value = texture(mask, UV).r;
//	if (inverted) {
//		value = 1.0 - value;
//	}
//	float alpha = smoothstep(cutoff, cutoff + smooth_size, value * (1.0 - smooth_size) + smooth_size);
//	COLOR = vec4(COLOR.rgb, alpha);
//}

shader_type canvas_item;

uniform sampler2D dissolve_texture;
uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.5;
uniform vec4 fade_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool fade = false;
uniform bool inverted = false;

void fragment() {
	if (dissolve_amount < 0.0001 || dissolve_amount > 0.9999 || fade) {
		COLOR = vec4(fade_color.rgb, dissolve_amount);
	} else {
		float sample = texture(dissolve_texture, UV).r;
		if (inverted) {
			sample = 1.0 - sample;
		}
		COLOR = vec4(fade_color.rgb, step(sample, dissolve_amount));
	}
}