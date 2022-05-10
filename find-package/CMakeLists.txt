cmake_minimum_required(VERSION 3.20)
project(FindPackage)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(AboutCMake 1.0 REQUIRED)

add_executable(example main.cpp)
target_link_libraries(example AboutCMake::sum)

message(NOTICE "Headers: ${AboutCMake_INCLUDE_DIRS}")