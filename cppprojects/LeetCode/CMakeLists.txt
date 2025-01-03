cmake_minimum_required(VERSION 3.10)

project(LeetCode)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

file(GLOB SOLVED_SRC "solved/**/*.cpp")
file(GLOB UNSOLVED_SRC "unsolved/**/*.cpp")

add_executable(solved_exe ${SOLVED_SRC})
add_executable(unsolved_exe ${UNSOLVED_SRC})

# Include paths or libraries (optional)
include_directories(${CMAKE_SOURCE_DIR}/include)
