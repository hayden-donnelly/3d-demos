gcc -o triangle/main triangle/main.c -lglfw -L deps/builds/ -lglad -ltext-loader &&
mv triangle/main triangle/builds/main &&
triangle/builds/main
