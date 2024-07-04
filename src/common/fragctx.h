#pragma once
#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <stdlib.h>

int run_frag_context(
    const char* fragment_shader_path, 
    const int window_height, 
    const int window_width, 
    const char* window_title
);
