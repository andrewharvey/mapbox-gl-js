uniform mat4 u_matrix;
uniform sampler2D u_imagev;

attribute vec2 a_pos;
attribute vec2 a_texture_pos;

varying vec2 v_pos;
varying vec4 v_pixel;

float getHeight(vec2 coord) {
    vec4 data = texture2D(u_imagev, coord) * 256.0;
    float r = data.r;
    float g = data.g * 256.0;
    float b = data.b * 256.0 * 256.0;

    float rgb = (r + g + b) * 0.1;
    float height = abs(rgb - 10000.0);
    return (height * 10.0) - 30000.0;
}

void main() {
    v_pos = a_texture_pos / 8192.0;
    v_pixel = texture2D(u_imagev, v_pos);

    vec2 vuv = (a_texture_pos / 8192.0) / 2.0 + 0.25;

    float height = getHeight(vuv);
    gl_Position = u_matrix * vec4(a_pos, height, 1.0);
}
