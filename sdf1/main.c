#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <text-loader/loader.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const int WIDTH = 512;
const int HEIGHT = 512;

void error_callback(int error, const char* description)
{
    fprintf(stderr, "Error: %s\n", description);
}

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if(key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
    {
        glfwSetWindowShouldClose(window, GLFW_TRUE);
    }
}

int main() 
{
    const char* vertex_shader_source = read_text_file("sdf1/default.vert");
    const char* fragment_shader_source = read_text_file("sdf1/default.frag");
    
    if(glfwInit() == GLFW_FALSE) 
    {
        printf("Failed to intialize glfw\n");
        return -1;
    }
    glfwSetErrorCallback(error_callback);

    GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "SDF1", NULL, NULL);
    if(window == NULL)
    {
        printf("Failed to create window\n");
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetKeyCallback(window, key_callback);

    int version = gladLoadGL(glfwGetProcAddress);
    if(version == 0) 
    {
        printf("Failed to initialize OpenGL context\n");
        return -1;
    }
    printf("Loaded OpenGL %d.%d\n", GLAD_VERSION_MAJOR(version), GLAD_VERSION_MINOR(version));

    GLuint vertex_shader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertex_shader, 1, &vertex_shader_source, NULL);
    glCompileShader(vertex_shader);

    GLuint fragement_shader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragement_shader, 1, &fragment_shader_source, NULL);
    glCompileShader(fragement_shader);

    GLuint shader_program = glCreateProgram();
    glAttachShader(shader_program, vertex_shader);
    glAttachShader(shader_program, fragement_shader);

    glLinkProgram(shader_program);
    glDeleteShader(vertex_shader);
    glDeleteShader(fragement_shader);

    GLfloat vertices[] = 
    {
        // Geometry Coordinates     Texture Coordinates
        -1.0f, -1.0f,               0.0f, 0.0f,
        -1.0f, 1.0f,                0.0f, 1.0f,
        1.0f, -1.0f,                1.0f, 0.0f,

        1.0f, -1.0f,                1.0f, 0.0f,
        -1.0f, 1.0f,                0.0f, 1.0f,
        1.0f, 1.0f,                 1.0f, 1.0f
    };
    GLuint VAO, VBO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    
    glBindVertexArray(VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT)*4, (void*)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT)*4, (void*)(2*sizeof(GL_FLOAT)));
    glEnableVertexAttribArray(1);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);


    while(!glfwWindowShouldClose(window))
    {
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        glUseProgram(shader_program);
        glBindVertexArray(VAO);
        glDrawArrays(GL_TRIANGLES, 0, 6);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteShader(shader_program);

    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
