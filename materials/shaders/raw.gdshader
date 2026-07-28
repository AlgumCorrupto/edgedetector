shader_type canvas_item;

#include "include/sobel.gdshaderinc"

void fragment() {
	float G = sobel(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
	COLOR = vec4(vec3(G), 1.0);
}
