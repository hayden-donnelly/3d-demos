#version 330 core
in vec2 fragment_pos;
uniform float u_time;

vec3 rot_3d(vec3 p, vec3 axis, float angle)
{
    return mix(dot(axis, p) * axis, p, cos(angle)) + cross(axis, p) * sin(angle);
}

float smooth_union(float d1, float d2, float k)
{
    float h = clamp(0.5 + 0.5 * (d2 - d1) / k, 0.0f, 1.0f);
    return mix(d2, d1, h) - k * h * (1.0f - h);
}

float sd_sphere(vec3 p, float s)
{
    return length(p) - s;
}

float sd_cube(vec3 p, vec3 b)
{
    vec3 q = abs(p) - b;
    return length(max(q, 0.0f)) + min(max(q.x, max(q.y, q.z)), 0.0f);
}

float map(vec3 p)
{
    float sphere_translation = sin(u_time) * 3.0f;
    float sphere1 = sd_sphere(p - vec3(0.0f, sphere_translation, 0.0f), 1.0f);
    float sphere2 = sd_sphere(p - vec3(sphere_translation, 0.0f, 0.0f), 1.0f);
    float cube = sd_cube(rot_3d(p, vec3(0.0, 1.0f, 0.0f), u_time * 0.5f), vec3(0.75));
    float combined = smooth_union(sphere1, sphere2, 0.5f);
    combined = smooth_union(cube, combined, 0.5f);
    return combined;
}

void main()
{
    float fov = 1.3;
    vec2 uv = fragment_pos - 0.5f;
    vec3 ray_origin = vec3(0.0, 0.0, -3.0);
    vec3 ray_dir = normalize(vec3(uv * fov, 1.0));
    float t = 0.0;
    
    for(int i = 0; i < 80; i++)
    {
        vec3 p = ray_origin + ray_dir * t;
        float d = map(p);
        t += d;
        if(d < .001 || t > 100.0) { break; }
    }

    vec3 color = vec3(t * 0.2, t * 0.2, 1.0f);
    gl_FragColor = vec4(color, 1.0);
}
