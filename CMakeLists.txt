cmake_minimum_required(VERSION 3.28)
project(demo)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(ENABLE_COVERAGE "Enable a Code Coverage build." ON)
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(ccache)
include(target)

# CPM
include(CPM)
if(NOT CPM_SOURCE_CACHE)
    set(CPM_SOURCE_CACHE ${PROJECT_SOURCE_DIR}/.cpm_cache)
endif()
set(CPM_USE_NAMED_CACHE_DIRECTORIES ON)
message(STATUS "CPM_SOURCE_CACHE: ${CPM_SOURCE_CACHE}")


add_executable(demo main.cpp)
include_directories_default(demo)

add_custom_target(version
        ${CMAKE_COMMAND} -D SRC=${CMAKE_SOURCE_DIR}/include/version.h.in
                         -D DST=${CMAKE_BINARY_DIR}/include/version.h
                         -P ${CMAKE_SOURCE_DIR}/cmake/version.cmake
)

add_dependencies(demo version)


include(CTest)
if(BUILD_TESTING)
    add_custom_target(tests)
    message(STATUS "add tests target")

    include(coverage)
    create_coverage_targets()
    message(STATUS "coverage enabled")
    find_package(Catch2 QUIET)
    if(NOT Catch2_FOUND)
        CPMAddPackage(
                NAME Catch2
                VERSION 3.8.0
                GITHUB_REPOSITORY catchorg/Catch2
                OPTIONS
                "CATCH_BUILD_TESTING OFF"
                "CATCH_BUILD_EXAMPLES OFF"
                "CATCH_INSTALL_DOCS OFF"
                "BUILD_TESTING OFF"
        )
        list(APPEND CMAKE_MODULE_PATH ${Catch2_SOURCE_DIR}/extras)
    endif()
    find_package(Catch2 REQUIRED)
    include(Catch)
    add_subdirectory(test)
endif ()
include(doxygen)
