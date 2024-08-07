#!/bin/bash

# Set the path to the shaders folder.
SHADERS_FOLDER="src/shaders"

# Set the output header file name.
OUTPUT_FILE="src/shader_sources.h"

# Create or overwrite the output file.
echo "/* Generated shader header file */" > $OUTPUT_FILE
echo -e "#ifdef __cplusplus\nextern "C" {\n#endif" >> $OUTPUT_FILE

# Loop through all .vert and .frag files in the shaders folder
for shader_file in $SHADERS_FOLDER/*.{vert,frag}; do
    # Get the shader name without the extension
    shader_name=$(basename "$shader_file" | cut -d. -f1)
    
    # Get the shader extension
    shader_ext=$(basename "$shader_file" | cut -d. -f2)
    
    # Determine the suffix based on the shader extension
    if [ "$shader_ext" == "vert" ]; then
        shader_suffix="_vert"
    elif [ "$shader_ext" == "frag" ]; then
        shader_suffix="_frag"
    fi
    
    # Read the shader content and convert it to a single line string.
    #shader_content=$(cat "$shader_file" | sed 's/"/\\"/g' | tr -d "\\n")
    shader_content=$(sed 's/$/\\n/' "$shader_file" | tr -d '\n')
    variable_name="${shader_name}${shader_suffix}_source"
    # Append the shader string to the output file with the appropriate suffix.
    echo "const char* ${variable_name} = \"$shader_content\";" >> $OUTPUT_FILE
done

echo -e "#ifdef __cplusplus\n}\n#endif\n" >> $OUTPUT_FILE
