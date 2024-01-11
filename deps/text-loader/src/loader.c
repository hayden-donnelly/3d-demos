#include <stdlib.h>
#include <stdio.h>
#include <text-loader/loader.h>

const char* read_text_file(const char* path)
{
	FILE* file_ptr = fopen(path, "r");
	if(file_ptr == NULL) 
	{ 
		printf("Could not open %s", path); 
		return NULL;
	}

	uint text_length = 0;
	char ch;
	while(1)
	{
		ch = fgetc(file_ptr);
		text_length++;
		if(ch == EOF) { break; }
	}
	rewind(file_ptr);

	char* text = malloc(sizeof(char)*text_length);
	for(int i = 0; i < text_length; i++)
	{
		text[i] = fgetc(file_ptr);
	}
	fclose(file_ptr);
	return text;
}
