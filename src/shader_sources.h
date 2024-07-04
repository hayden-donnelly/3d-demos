/* Generated shader header file */
#ifdef __cplusplus
extern C {
#endif
const char* simple_frag_ctx_vert_source = "#version 330 core\nlayout (location = 0) in vec2 vertex_pos;\nlayout (location = 1) in vec2 texture_pos;\n\nout vec2 fragment_pos;\n\nvoid main()\n{\n    gl_Position = vec4(vertex_pos.x, vertex_pos.y, 0.0, 1.0);\n    fragment_pos = texture_pos;\n}\n";
const char* sdf1_frag_source = "#version 330 core\nin vec2 fragment_pos;\nuniform float u_time;\n\nvec3 rot_3d(vec3 p, vec3 axis, float angle)\n{\n    return mix(dot(axis, p) * axis, p, cos(angle)) + cross(axis, p) * sin(angle);\n}\n\nfloat smooth_union(float d1, float d2, float k)\n{\n    float h = clamp(0.5 + 0.5 * (d2 - d1) / k, 0.0f, 1.0f);\n    return mix(d2, d1, h) - k * h * (1.0f - h);\n}\n\nfloat sd_sphere(vec3 p, float s)\n{\n    return length(p) - s;\n}\n\nfloat sd_cube(vec3 p, vec3 b)\n{\n    vec3 q = abs(p) - b;\n    return length(max(q, 0.0f)) + min(max(q.x, max(q.y, q.z)), 0.0f);\n}\n\nfloat map(vec3 p)\n{\n    float sphere_translation = sin(u_time) * 3.0f;\n    float sphere1 = sd_sphere(p - vec3(0.0f, sphere_translation, 0.0f), 1.0f);\n    float sphere2 = sd_sphere(p - vec3(sphere_translation, 0.0f, 0.0f), 1.0f);\n    float cube = sd_cube(rot_3d(p, vec3(0.0, 1.0f, 0.0f), u_time * 0.5f), vec3(0.75));\n    float combined = smooth_union(sphere1, sphere2, 0.5f);\n    combined = smooth_union(cube, combined, 0.5f);\n    return combined;\n}\n\nvoid main()\n{\n    float fov = 1.3;\n    vec2 uv = fragment_pos - 0.5f;\n    vec3 ray_origin = vec3(0.0, 0.0, -3.0);\n    vec3 ray_dir = normalize(vec3(uv * fov, 1.0));\n    float t = 0.0;\n    \n    for(int i = 0; i < 80; i++)\n    {\n        vec3 p = ray_origin + ray_dir * t;\n        float d = map(p);\n        t += d;\n        if(d < .001 || t > 100.0) { break; }\n    }\n\n    vec3 color = vec3(t * 0.2, t * 0.2, 1.0f);\n    gl_FragColor = vec4(color, 1.0);\n}\n";
#ifdef __cplusplus
}
#endif

