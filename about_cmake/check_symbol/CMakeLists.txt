# Try Compile
try_compile(ABOUT_CMAKE_HAS_POW_1
    ${CMAKE_BINARY_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/try_compile_has_pow.cpp
)
message(STATUS "ABOUT_CMAKE_HAS_POW_1=${ABOUT_CMAKE_HAS_POW_1}")

# Check Symbol Exists
include(CheckSymbolExists)
check_symbol_exists(pow math.h ABOUT_CMAKE_HAS_POW_2)
message(STATUS "ABOUT_CMAKE_HAS_POW_2=${ABOUT_CMAKE_HAS_POW_2}")

# Example
add_executable(check_symbol main.cpp)
if (ABOUT_CMAKE_HAS_POW_1)
    target_compile_definitions(check_symbol PUBLIC HAS_POW)
endif()
