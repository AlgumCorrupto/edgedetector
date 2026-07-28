shader_type canvas_item;

#include "include/sobel.gdshaderinc"
#include "include/adaptive_threshold.gdshaderinc"

global uniform float threshold_low;
global uniform float threshold_high;

global uniform bool use_adaptive_threshold;
global uniform int window_size;

void fragment() {
	float G = sobel(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
	float bias = 1.0;
	if(use_adaptive_threshold)
		bias = adaptive_threshold(window_size, TEXTURE, UV, TEXTURE_PIXEL_SIZE);
	
	if(G > threshold_high * bias) {
		COLOR = vec4(vec3(1.0), 1.0);
	} else if(G > threshold_low * bias) {
		COLOR = vec4(vec3(0.5), 1.0);
	} else {
		COLOR = vec4(vec3(0.0), 1.0);
	}
}
