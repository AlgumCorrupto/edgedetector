shader_type canvas_item;

#include "include/sobel.gdshaderinc"
#include "include/adaptive_threshold.gdshaderinc"

global uniform float threshold_low;
global uniform float threshold_high;

global uniform bool use_adaptive_threshold;
global uniform int window_size;



const float color_no_edge = 0.0;
const float color_edge = 1.0;

float left_shoulder(float x, float a, float b) {
    if (x <= a) return 1.0;
    if (x >= b) return 0.0;
    return (b - x) / (b - a);
}

float right_shoulder(float x, float a, float b) {
    if (x <= a) return 0.0;
    if (x >= b) return 1.0;
    return (x - a) / (b - a);
}

// transformando em regras fuzzy
vec2 fuzzify(float G, float bias) {
    return vec2(
        left_shoulder(G, threshold_low * bias, threshold_high + bias), // se G < threshold_low
        right_shoulder(G, threshold_low * bias, threshold_high + bias) // se G > threshold_high
    );
}

void fragment() {
    float G = sobel(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
	float bias = 1.0;
	if(use_adaptive_threshold)
		bias = adaptive_threshold(window_size, TEXTURE, UV, TEXTURE_PIXEL_SIZE);

    vec2 rules = fuzzify(G, bias);

    float edge = (color_no_edge * rules.x + color_edge * rules.y) / (rules.x + rules.y);

    COLOR = vec4(vec3(edge), 1.0);
}
