extern number u_time;
extern number shine_speed;
extern number shine_width;
extern number shine_strength;

extern vec4 shine_1;
extern vec4 shine_2;
extern vec4 shine_3;
extern vec4 shine_4;

vec3 shine_palette(number t) {
    t = clamp(t, 0.0, 1.0);
    if (t < 0.333333) {
        return mix(shine_1.rgb, shine_2.rgb, t * 3.0);
    }
    if (t < 0.666667) {
        return mix(shine_2.rgb, shine_3.rgb, (t - 0.333333) * 3.0);
    }
    return mix(shine_3.rgb, shine_4.rgb, (t - 0.666667) * 3.0);
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 pixel = Texel(texture, texture_coords) * colour;
    if (pixel.a <= 0.0) {
        return pixel;
    }
    number t = u_time * shine_speed;
    number wave_a = sin(texture_coords.x * 85.0 + texture_coords.y * 32.0 - t * 2.2);
    number wave_b = sin(texture_coords.x * 38.0 - texture_coords.y * 57.0 + t * 1.35);
    number wave_c = sin((texture_coords.x + texture_coords.y) * 24.0 + t * 0.8);
    number wave = wave_a * 0.55 + wave_b * 0.3 + wave_c * 0.15;
    number field = wave * 0.5 + 0.5;
    number amount = smoothstep(0.3 - shine_width * 0.2, 0.82 + shine_width * 0.1, field);
    number palette_t = smoothstep(0.2, 0.95, field);
    vec3 shine_colour = shine_palette(palette_t);
    vec3 screened = vec3(1.0) - ((vec3(1.0) - pixel.rgb) * (vec3(1.0) - shine_colour));
    pixel.rgb = mix(pixel.rgb, screened, amount * shine_strength);
    return pixel;
}
