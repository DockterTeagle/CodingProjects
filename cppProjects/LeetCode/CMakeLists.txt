cmake_minimum_required(VERSION 3.10)

project(LeetCode)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS
    ON
    CACHE INTERNAL "")

if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES
      ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L${CMAKE_SOURCE_DIR}/include")
include_directories(${CMAKE_SOURCE_DIR}/include)
file(GLOB SOLVED_SRC "src/solved/**/*.cpp")
file(GLOB UNSOLVED_SRC "src/unsolved/**/*.cpp")
add_executable(solved_exe ${SOLVED_SRC})
add_executable(unsolved_exe ${UNSOLVED_SRC})

# Include paths or libraries (optional)
target_include_directories(solved_exe PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_include_directories(unsolved_exe PRIVATE ${CMAKE_SOURCE_DIR}/include)
