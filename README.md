# 3d-demos
3D graphics demos with OpenGL.

## Dependencies
- gcc
- cmake
- glfw (included in repo)
- glad (included in repo)
- libkbcommon
- libX11
- libXi
- libXcursor
- libXext
- libXinerama
- libXrandr
- libXrender

The dependencies which aren't included in this repo can be access through a Nix dev shell
by executing `nix develop` provided that you have Nix installed and Flakes enabled.

## Building and Running
### CMake
1. Create build directory.
```
mkdir build
```
2. CD into build directory.
```
cd build
```
3. Configure build with CMake.
```
cmake ..
```
4. Build with Make.
```
make
```
5. Run the program.
```
./demos
```
