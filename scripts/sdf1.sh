mkdir -p build &&
echo $(pwd) &&
gcc -o ./src/sdf1/main ./src/sdf1/main.c -lglfw -L ./build/ -lglad -ldemo-common -I ./external/glad/include/ &&
rm ./src/sdf1/main.o &&
mv ./main ./build/sdf1 &&
./build/sdf1
