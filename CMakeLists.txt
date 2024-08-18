cmake_minimum_required(VERSION 3.10)
project(SDF1 C)

set(CMAKE_C_STANDARD 99)
set(BUILD_SHARED_LIBS OFF)

# Set directories.
set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
set(BUILD_DIR ${CMAKE_BINARY_DIR})
set(GLAD_DIR ${CMAKE_SOURCE_DIR}/external/glad)
set(GLFW_DIR ${CMAKE_SOURCE_DIR}/external/glfw)

# Add GLAD library.
add_library(glad STATIC ${GLAD_DIR}/src/gl.c)
target_include_directories(glad PUBLIC ${GLAD_DIR}/include)

# Add GLFW library.
set(GLFW_BUILD_DOCS OFF)
set(GLFW_BUILD_TESTS OFF)
set(GLFW_BUILD_EXAMPLES OFF)
set(GLFW_BUILD_WAYLAND OFF)
set(GLFW_BUILD_X11 ON)
add_subdirectory(${GLFW_DIR} ${CMAKE_BINARY_DIR}/glfw)

# Add SDF1 executable.
set(SDF1_SRCS
    ${SRC_DIR}/common/fragctx.c
    ${SRC_DIR}/sdf1.c
)

add_executable(sdf1 ${SDF1_SRCS})

# Include directories.
target_include_directories(sdf1 PRIVATE ${GLAD_DIR}/include)

# Link libraries.
target_link_libraries(sdf1 PRIVATE glad glfw)

# Custom command to generate shader header.
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/shaders.h
    COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/shaders_to_header.sh
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Generating shader header"
)

# Add shader header as a dependency.
add_custom_target(generate_shader_header DEPENDS ${CMAKE_BINARY_DIR}/shaders.h)
add_dependencies(sdf1 generate_shader_header)

# Set output directory.
set_target_properties(sdf1 PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}
)

# Custom target for running the executable.
add_custom_target(run
    COMMAND ${BUILD_DIR}/sdf1
    DEPENDS sdf1
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

# Clean target.
set_directory_properties(PROPERTIES ADDITIONAL_CLEAN_FILES "${BUILD_DIR}/shaders.h")
