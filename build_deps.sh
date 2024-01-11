mkdir -p deps/builds/

# glad
gcc -c deps/glad/src/gl.c &&
ar rcs libglad.a gl.o &&
rm gl.o &&
mv libglad.a deps/builds/

# text-loader
gcc -c deps/text-loader/src/loader.c &&
ar rcs libtext-loader.a loader.o &&
rm loader.o &&
mv libtext-loader.a deps/builds/
