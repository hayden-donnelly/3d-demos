gcc -o demo1/main demo1/main.c -lglfw -L deps/builds/ -lglad -ltext-loader &&
mv demo1/main demo1/builds/main &&
demo1/builds/main
