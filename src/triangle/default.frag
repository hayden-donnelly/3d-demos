#version 330 core

in vec2 fragment_pos;

void main()
{
    gl_FragColor = vec4(fragment_pos.x, 0.0f, 1.0f, 1.0f);
}
