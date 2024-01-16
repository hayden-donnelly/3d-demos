mkdir -p deps/builds/
cd deps

# glad
cd glad &&
gcc -c src/gl.c &&
ar rcs libglad.a gl.o &&
rm gl.o &&
mv libglad.a ../builds/ &&
cd ..

# demo-utils
cd demo-utils &&
gcc -c src/loader.c src/fragctx.c -lglfw -L ../builds/ -lglad &&
ar rcs libdemo-utils.a loader.o fragctx.o &&
rm loader.o fragctx.o &&
mv libdemo-utils.a ../builds/
