#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <stdio.h>

const int WIDTH = 1280;
const int HEIGHT = 720;

int main() 
{
    if (glfwInit() == GLFW_FALSE) 
    {
        printf("Failed to intialize glfw\n");
        return -1;
    }
    GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "LearnOpenGL", NULL, NULL);
    if(window == NULL)
    {
        printf("Failed to create window\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);

    int version = gladLoadGL(glfwGetProcAddress);
    if (version == 0) {
        printf("Failed to initialize OpenGL context\n");
        return -1;
    }

    printf("Loaded OpenGL %d.%d\n", GLAD_VERSION_MAJOR(version), GLAD_VERSION_MINOR(version));
}