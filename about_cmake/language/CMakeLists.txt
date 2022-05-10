# ____________________________________
# Print

message(STATUS "Hello, world!")

# ____________________________________
# Variables
set(var0 "")           # var0 = ""
# command(${var0})     # 0 args

set(var1_a a)          # var1_a = "a"
set(var1_b "a b")      # var1_b = "a b"
# command(${var1_b})   # 1 arg

set(var2 a b)          # var2 = "a;b"
# command(${var2})     # 2 args = a b
# command("${var2}")   # 1 arg = "a;b"

# Environment variables
set(user $ENV{USER})
message(STATUS "User: " ${user})

# ____________________________________
# Control flow

if(var0)
elseif(var1_a)
else()
endif()

foreach(i 1 2 3)
endforeach()

while(i LESS 4)
endwhile()

# ____________________________________
# Commands

function(sum x y result)
    MATH(EXPR tmp "${x}+${y}")
    set(${result} ${tmp} PARENT_SCOPE)
    return()
endfunction()

set(x 1)
set(y 2)
sum(${x} ${y} result)
message(STATUS "${x} + ${y} = ${result}")

# A macro does not push and pop a new variable scope
# the arguments to a macro are not treated as variables 
# but as strings replaced prior to execution.
macro(assert test comment)
    if(NOT ${test})
        message("Assertion failed: ${comment}")
    endif()
endmacro()

string(COMPARE EQUAL abc abc result)
assert(result "strings are not equal")

# Variable arguments
# ARGC, ARGV0, ARGV1, etc
# ARGV -> list of all the arguments
# ARGN -> list of all the arguments after the formal arguments

# ____________________________________
# Cache Variables
# Once the variable is in the cache, the command have no effect

# Bools
option(ABOUT_CMAKE_VAR_BOOL "Documentation" ON)
# Strings
set(ABOUT_CMAKE_VAR_STRING "1" CACHE STRING "Documentation")

# Force set
#set(ABOUT_CMAKE_VAR_BOOL OFF CACHE BOOL "documentation" FORCE)

# Advanced variables
option(ABOUT_CMAKE_VAR_ADVANCED "Documentation" OFF)
mark_as_advanced(ABOUT_CMAKE_VAR_ADVANCED)
