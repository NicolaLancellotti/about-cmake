add_library(sum
    sum.cpp
)

target_include_directories(sum PUBLIC
    # Generator expressions
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
