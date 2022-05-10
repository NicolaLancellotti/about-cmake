# ______________________________________________________________________________
# Project

cmake_minimum_required(VERSION 3.20)
project(AboutCMake VERSION 1.0.0)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# ______________________________________________________________________________
# Output Directories

# executables - created by add_executable (.exe on Windows, no extension on UNIX)
# dynamic-link libraries - created by add_library with the SHARED option on Windows platforms (.dll)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

# shared libraries - created by add_library with the SHARED option on UNIX-like platforms (.so on most UNIX, .dylib on Mac)
# loadable modules - created by add_library with the MODULE option (.dll on Windows, .so on UNIX)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

# static libraries - created by add_library with the STATIC option (.lib on Windows, .a on UNIX, Cygwin, and MinGW)
# import libraries - a linkable file created by a dynamic-link library that exports symbols (.lib on most Windows, .dll.a on Cygwin and MinGW)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

# ______________________________________________________________________________
# Subdirectories

add_subdirectory(language)
add_subdirectory(configure_file)
add_subdirectory(check_symbol)
add_subdirectory(custom_target)
add_subdirectory(lib)

# ______________________________________________________________________________
# Generate Package Config

set(PACKAGE_NAME AboutCMake)
set(PACKAGE_CONFIG_BUILD ${CMAKE_CURRENT_BINARY_DIR}/cmake)
set(PACKAGE_CONFIG_INSTALL lib/cmake/${PACKAGE_NAME})

set(ABOUT_CMAKE_INCLUDE_INSTALL_DIR include)

include(CMakePackageConfigHelpers)

configure_package_config_file(CMakeUtils/Config.cmake.in
        ${PACKAGE_CONFIG_BUILD}/install/${PACKAGE_NAME}Config.cmake
        INSTALL_DESTINATION ${PACKAGE_CONFIG_INSTALL}
        PATH_VARS ABOUT_CMAKE_INCLUDE_INSTALL_DIR
)

configure_file(CMakeUtils/ConfigBuild.cmake.in
        ${PACKAGE_CONFIG_BUILD}/${PACKAGE_NAME}Config.cmake @ONLY)

write_basic_package_version_file(
        ${PACKAGE_CONFIG_BUILD}/${PACKAGE_NAME}ConfigVersion.cmake
        COMPATIBILITY SameMajorVersion
)

# ______________________________________________________________________________
# Install

install(SCRIPT CMakeUtils/install-start.cmake)

install(TARGETS sum
        EXPORT ${PACKAGE_NAME}Targets
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION lib
)

install(EXPORT ${PACKAGE_NAME}Targets
        FILE ${PACKAGE_NAME}Targets.cmake
        NAMESPACE ${PACKAGE_NAME}::
        DESTINATION ${PACKAGE_CONFIG_INSTALL}
)

install(FILES
        ${PACKAGE_CONFIG_BUILD}/install/${PACKAGE_NAME}Config.cmake
        ${PACKAGE_CONFIG_BUILD}/${PACKAGE_NAME}ConfigVersion.cmake
        DESTINATION ${PACKAGE_CONFIG_INSTALL}
)

install(DIRECTORY include DESTINATION .)

install(CODE "message(\"*** DONE ***\")")

# ______________________________________________________________________________
# Export Targets in Build Tree

export(EXPORT ${PACKAGE_NAME}Targets
        FILE ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PACKAGE_NAME}Targets.cmake
        NAMESPACE ${PACKAGE_NAME}::
)

# ______________________________________________________________________________
# CMake Package Registry

set(CMAKE_EXPORT_PACKAGE_REGISTRY OFF)
export(PACKAGE ${PACKAGE_NAME})
