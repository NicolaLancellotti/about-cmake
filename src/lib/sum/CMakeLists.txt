add_library(sum STATIC
        ${AC_SUM_INCLUDE_BUILD_DIR}/sum.h
        sum.cpp
)

target_include_directories(sum PUBLIC
    # Generator expressions
    $<BUILD_INTERFACE:${AC_SUM_INCLUDE_BUILD_DIR}>
    $<INSTALL_INTERFACE:${AC_INCLUDE_INSTALL_DIR}>
)
