cmake_minimum_required(VERSION 3.3)
project(SDF1 C)

set(CMAKE_C_STANDARD 11)

set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
set(BUILD_DIR ${CMAKE_BINARY_DIR})
set(GLAD_DIR ${CMAKE_SOURCE_DIR}/external/glad)
set(GLFW_DIR ${CMAKE_SOURCE_DIR}/external/glfw)

set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_INSTALL OFF CACHE BOOL "" FORCE)
add_subdirectory(${GLFW_DIR})

add_library(glad STATIC ${GLAD_DIR}/src/gl.c)
target_include_directories(glad PUBLIC ${GLAD_DIR}/include)

set(SDF1_SRCS
    ${SRC_DIR}/common/fragctx.c
    ${SRC_DIR}/sdf1.c
)

add_executable(sdf1 ${SDF1_SRCS})

target_include_directories(sdf1 PRIVATE 
    ${GLAD_DIR}/include
    ${GLFW_DIR}/include
)

target_link_libraries(sdf1 PRIVATE glad glfw)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/shaders.h
    COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/shaders_to_header.sh
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Generating shader header"
)

add_custom_target(generate_shader_header DEPENDS ${CMAKE_BINARY_DIR}/shaders.h)
add_dependencies(sdf1 generate_shader_header)

set_target_properties(sdf1 PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}
)

add_custom_target(run
    COMMAND ${BUILD_DIR}/sdf1
    DEPENDS sdf1
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

set_directory_properties(PROPERTIES ADDITIONAL_CLEAN_FILES "${BUILD_DIR}/shaders.h")
