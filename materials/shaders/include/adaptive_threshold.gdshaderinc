#include "utils.gdshaderinc"

float adaptive_threshold(int window_size, sampler2D tex, vec2 uv, vec2 tex_size) {
	float sum = 0.0;

	for (int y = -window_size; y <= window_size; ++y)
	for (int x = -window_size; x <= window_size; ++x) {
	    sum += luminance(
	        texture(tex,uv + vec2(float(x), float(y)) * tex_size).rgb
	    );
	}
	
	return sum / float((2 * window_size + 1) * (2 * window_size + 1));
}