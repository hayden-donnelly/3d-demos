mkdir -p build

# glad
cd ./external/glad/ &&
gcc -c src/gl.c -I ./include/ &&
ar rcs libglad.a gl.o &&
rm gl.o &&
mv libglad.a ../../build/ &&
cd ../..
