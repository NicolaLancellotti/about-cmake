cmake_minimum_required(VERSION 3.20)
project(find_package VERSION 1.0.0)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(AboutCMake 1.0.0 REQUIRED)
message(NOTICE "AboutCMake_INCLUDE_DIRS: ${AboutCMake_INCLUDE_DIRS}")

add_executable(find_package main.cpp)
target_link_libraries(find_package AboutCMake::sum)
