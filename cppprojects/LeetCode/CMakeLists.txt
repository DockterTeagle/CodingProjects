cmake_minimum_required(VERSION 3.10)

project(LeetCode)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

file(GLOB SOLVED_SRC "solved/**/*.cpp")
file(GLOB UNSOLVED_SRC "unsolved/**/*.cpp")

add_executable(solved_exe ${SOLVED_SRC})
add_executable(unsolved_exe ${UNSOLVED_SRC})

# Include paths or libraries (optional)
include_directories(${CMAKE_SOURCE_DIR}/include)
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES 
      ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

