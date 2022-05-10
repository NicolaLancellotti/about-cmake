# ______________________________________________________________________________
# Project
cmake_minimum_required(VERSION 3.20)
project(AboutCMake VERSION 1.0.0)

# ______________________________________________________________________________
# Variables
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(AC_CMAKE_UTILITY ${PROJECT_SOURCE_DIR}/CMakeUtility)
set(AC_FILES ${PROJECT_SOURCE_DIR}/files)

set(AC_GENERATED_HEADERS ${PROJECT_BINARY_DIR}/generated_headers)
set(AC_GENERATED_FILES ${PROJECT_BINARY_DIR}/generated_files)
set(AC_GENERATED_DOC ${PROJECT_BINARY_DIR}/doc)

set(AC_CONFIG_INSTALL_DESTINATION  lib/cmake/AboutCMake)
set(AC_INCLUDE_INSTALL_DIR include)
set(AC_SUM_INCLUDE_BUILD_DIR ${PROJECT_SOURCE_DIR}/include/sum)

# ______________________________________________________________________________
# Output Directories
# executables - Created by add_executable (.exe on Windows, no extension on UNIX)
# dynamic-link libraries - Created by add_library with the SHARED option on Windows platforms (.dll)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
# shared libraries - Created by add_library with the SHARED option on UNIX-like platforms (.so on most UNIX, .dylib on Mac)
# loadable modules - Created by add_library with the MODULE option (.dll on Windows, .so on UNIX)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
# static libraries - Created by add_library with the STATIC option (.lib on Windows, .a on UNIX, Cygwin, and MinGW)
# import libraries - A linkable file created by a dynamic-link library that exports symbols (.lib on most Windows, .dll.a on Cygwin and MinGW).
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

# ______________________________________________________________________________
# Configure File
set(HAS_HELLO_WORLD ON)
set(AC_HELLO_WORLD "Hello, world!")

configure_file(
    ${AC_CMAKE_UTILITY}/configure.h.in
    ${AC_GENERATED_HEADERS}/configure.h
    @ONLY
)

# ______________________________________________________________________________
# Try Compile
try_compile(AC_HAS_POW
    ${CMAKE_BINARY_DIR}
    ${AC_CMAKE_UTILITY}/try_compile_has_pow.cpp
)
message(STATUS "AC_HAS_POW=${AC_HAS_POW}")

# Or the same by using a module
include(CheckSymbolExists)
check_symbol_exists(pow math.h AC_HAS_POW_2)
message(STATUS "AC_HAS_POW_2=${AC_HAS_POW_2}")

# Check
string(REPLACE 0 FALSE AC_HAS_POW_2 ${AC_HAS_POW_2})
string(REPLACE 1 TRUE AC_HAS_POW_2 ${AC_HAS_POW_2})
if (NOT AC_HAS_POW STREQUAL AC_HAS_POW_2)
    message(FATAL_ERROR "AC_HAS_POW != AC_HAS_POW_2")
endif()

# ______________________________________________________________________________
# Subdirectories
add_subdirectory(src)

# ______________________________________________________________________________
# Custom Target & Custom Command
add_custom_command(
    OUTPUT  ${PROJECT_BINARY_DIR}/doc/doc.txt
    COMMAND ${CMAKE_COMMAND}
    ARGS -E make_directory ${AC_GENERATED_DOC}
    COMMAND ${CMAKE_COMMAND}
    ARGS -E touch ${AC_GENERATED_DOC}/doc.txt
)
add_custom_target(generateDoc ALL
    DEPENDS ${AC_GENERATED_DOC}/doc.txt
)

# ______________________________________________________________________________
# Install
install(SCRIPT ${AC_CMAKE_UTILITY}/install-start.cmake)

install(DIRECTORY ${AC_GENERATED_DOC}/ DESTINATION doc)
install(FILES ${AC_FILES}/readme.txt DESTINATION . RENAME README.md)
install(PROGRAMS ${AC_FILES}/script.sh DESTINATION bin)

install(FILES ${AC_SUM_INCLUDE_BUILD_DIR}/sum.h DESTINATION include)
install(TARGETS bin sum
        EXPORT AboutCMakeTargets
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
install(EXPORT AboutCMakeTargets
        FILE AboutCMakeTargets.cmake
        NAMESPACE AboutCMake::
        DESTINATION ${AC_CONFIG_INSTALL_DESTINATION}
)

# Package configuration file
include(CMakePackageConfigHelpers)
configure_package_config_file(${AC_CMAKE_UTILITY}/AboutCMakeConfig.in
        ${AC_GENERATED_FILES}/AboutCMakeConfig.cmake
        INSTALL_DESTINATION ${AC_CONFIG_INSTALL_DESTINATION}
        PATH_VARS AC_INCLUDE_INSTALL_DIR
)
write_basic_package_version_file(
        "${CMAKE_CURRENT_BINARY_DIR}/AboutCMakeConfigVersion.cmake"
        COMPATIBILITY SameMajorVersion
)
install(FILES
        ${AC_GENERATED_FILES}/AboutCMakeConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/AboutCMakeConfigVersion.cmake
        DESTINATION ${AC_CONFIG_INSTALL_DESTINATION}
)

install(CODE "message(\"*** DONE ***\")")

# ______________________________________________________________________________
# Create a package configuration file in the build tree
export(EXPORT AboutCMakeTargets
    FILE AboutCMakeBuildTargets.cmake
    NAMESPACE AboutCMake::
)
configure_file(${AC_CMAKE_UTILITY}/AboutCMakeConfigBuild.in
    ${PROJECT_BINARY_DIR}/AboutCMakeConfig.cmake @ONLY)

# CMake Package Registry
set(CMAKE_EXPORT_PACKAGE_REGISTRY OFF)
export(PACKAGE AboutCMake)
