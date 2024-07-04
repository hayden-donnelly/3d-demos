#version 330 core
layout (location = 0) in vec2 vertex_pos;
layout (location = 1) in vec2 texture_pos;

out vec2 fragment_pos;

void main()
{
    gl_Position = vec4(vertex_pos.x, vertex_pos.y, 0.0, 1.0);
    fragment_pos = texture_pos;
}
