mkdir -p build &&
cd ./src &&
gcc -c ./triangle/main.c -I ../external/glad/include/ &&
gcc -o ../build/triangle ./main.o -L ../build/ -lglad -lglfw &&
rm ./main.o &&
cd .. &&
./build/triangle
