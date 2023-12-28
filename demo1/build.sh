gcc -c main.c &&
mv main.o builds/main.o &&
gcc -o builds/main builds/main.o -lglfw