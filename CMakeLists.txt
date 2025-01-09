cmake_minimum_required(VERSION 3.28)
project(demo)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(ccache)

# CPM
include(CPM)
if(NOT CPM_SOURCE_CACHE)
    set(CPM_SOURCE_CACHE ${PROJECT_SOURCE_DIR}/.cpm_cache)
endif()
set(CPM_USE_NAMED_CACHE_DIRECTORIES ON)
message(STATUS "CPM_SOURCE_CACHE: ${CPM_SOURCE_CACHE}")


include_directories(include)
add_executable(demo main.cpp)

add_custom_target(version
        ${CMAKE_COMMAND} -D SRC=${CMAKE_SOURCE_DIR}/include/version.h.in
                         -D DST=${CMAKE_BINARY_DIR}/include/version.h
                         -P ${CMAKE_SOURCE_DIR}/cmake/version.cmake
)

add_dependencies(demo version)

#CPMAddPackage(gh:jothepro/doxygen-awesome-css)
include(doxygen)
