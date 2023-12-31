mkdir -p deps/builds/

# glad
gcc -c deps/glad/src/gl.c &&
ar rcs libglad.a gl.o &&
rm gl.o &&
mv libglad.a deps/builds/