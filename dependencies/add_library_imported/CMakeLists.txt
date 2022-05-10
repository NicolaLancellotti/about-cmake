cmake_minimum_required(VERSION 3.20)
project(add_library_imported VERSION 1.0.0)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_library(sum STATIC IMPORTED)
set_target_properties(sum PROPERTIES IMPORTED_LOCATION ${SUM_BIN})
target_include_directories(sum INTERFACE ${SUM_INCLUDE})

add_executable(add_library_imported main.cpp)
target_link_libraries(add_library_imported sum)
