add_custom_command(
    OUTPUT ${PROJECT_BINARY_DIR}/generated/directory/file.txt
    COMMAND ${CMAKE_COMMAND}
    ARGS -E touch ${PROJECT_BINARY_DIR}/generated/directory/file.txt
)

add_custom_target(generate_file ALL
    DEPENDS ${PROJECT_BINARY_DIR}/generated/directory/file.txt
)
