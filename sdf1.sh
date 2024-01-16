mkdir -p sdf1/builds &&
gcc -o sdf1/main sdf1/main.c -lglfw -L deps/builds/ -lglad -ldemo-utils &&
mv sdf1/main sdf1/builds/main &&
sdf1/builds/main
