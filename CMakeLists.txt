cmake_minimum_required(VERSION 3.28)
project(demo)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(ccache)

include_directories(inc)
add_executable(demo main.cpp)

add_custom_target(version
        ${CMAKE_COMMAND} -D SRC=${CMAKE_SOURCE_DIR}/inc/version.h.in
                         -D DST=${CMAKE_SOURCE_DIR}/inc/version.h
                         -P ${CMAKE_SOURCE_DIR}/cmake/version.cmake
)

add_dependencies(demo version)
