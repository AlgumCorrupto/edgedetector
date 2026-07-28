float mean(vec3 c) {
	return (c.r + c.b + c.g) / 3.0;
}

float luminance(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}