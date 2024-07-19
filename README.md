# 3d-demos
3D graphics demos with OpenGL.

## Building and Running
1. Create build directory and cd into it.
```
mkdir build && cd build
```

2. Generate Makefiles with CMake.
```
cmake .. -D GLFW_BUILD_WAYLAND=0
```

3. Build and run with Make.
```
make run
```
