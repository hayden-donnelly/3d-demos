mkdir -p build &&
bash ./scripts/shaders_to_header.sh &&
cd ./src &&
gcc -c ./common/fragctx.c ./sdf1.c -I ../external/glad/include/ &&
gcc -o ../build/sdf1 ./fragctx.o ./sdf1.o -L ../build/ -lglad -lglfw &&
rm ./fragctx.o ./sdf1.o &&
cd .. &&
./build/sdf1
