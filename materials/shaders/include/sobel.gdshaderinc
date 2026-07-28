const mat3 Kx = mat3(
    vec3(-1, -2, -1),
    vec3( 0,  0,  0),
    vec3( 1,  2,  1)
);

const mat3 Ky = mat3(
    vec3(-1,  0,  1),
    vec3(-2,  0,  2),
    vec3(-1,  0,  1)
);

#include "utils.gdshaderinc"

float sobel_convolute(sampler2D tex, vec2 uv, vec2 texel_size, mat3 kernel) {
    float acc = 0.0;
    for (int y = -1; y <= 1; ++y) {
        for (int x = -1; x <= 1; ++x) {
			vec2 curr_uv = uv + vec2(float(x), float(y)) * texel_size;
			float pixel = luminance(texture(tex, curr_uv).rgb);
			acc += pixel * kernel[y + 1][x + 1];

        }
    }

    return acc;
}

float sobel(sampler2D tex, vec2 uv, vec2 tex_size) {
	float Gx = sobel_convolute(tex, uv, tex_size, Kx);
	float Gy = sobel_convolute(tex, uv, tex_size, Ky);
	float G = length(vec2(Gx, Gy)); //  / 4.472136
	return G;
}