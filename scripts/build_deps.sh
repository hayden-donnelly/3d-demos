mkdir -p build

# glad
cd ./external/glad/ &&
gcc -c src/gl.c -I ./include/ &&
ar rcs libglad.a gl.o &&
rm gl.o &&
mv libglad.a ../../build/ &&
cd ../..

# demo-utils
cd ./src/common/ &&
gcc -c loader.c fragctx.c -lglfw -L ../../build/ -lglad -I ../../external/glad/include/ &&
ar rcs libdemo-common.a loader.o fragctx.o &&
rm loader.o fragctx.o &&
mv libdemo-common.a ../../build/
