set(HAS_HELLO_WORLD ON)
set(ABOUT_CMAKE_HELLO_WORLD "Hello, world!")

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/configure.h.in
    ${PROJECT_BINARY_DIR}/generated/configure.h
    @ONLY
)

# Example
add_executable(configure_file main.cpp)
target_include_directories(configure_file PRIVATE 
    ${PROJECT_BINARY_DIR}/generated
)
