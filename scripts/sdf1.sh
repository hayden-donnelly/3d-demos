mkdir -p build &&
cd ./src &&
gcc -c ./common/loader.c ./common/fragctx.c ./sdf1/main.c -I ../external/glad/include/ &&
gcc -o ../build/sdf1 ./loader.o ./fragctx.o ./main.o -L ../build/ -lglad -lglfw &&
rm ./loader.o ./fragctx.o ./main.o &&
cd .. &&
./build/sdf1
