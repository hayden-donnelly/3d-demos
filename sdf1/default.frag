#version 330 core

in vec2 fragment_pos;

void main()
{
    gl_FragColor = vec4(fragment_pos.x, fragment_pos.y, 0.0, 1.0);
}
