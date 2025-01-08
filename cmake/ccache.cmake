find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    if(NOT CMAKE_C_COMPILER_LAUNCHER)
        set(CMAKE_C_COMPILER_LAUNCHER ccache)
    endif()
    if(NOT CMAKE_C_LINKER_LAUNCHER)
        set(CMAKE_C_LINKER_LAUNCHER ccache)
    endif()
    if(NOT CMAKE_CXX_COMPILER_LAUNCHER)
        set(CMAKE_CXX_COMPILER_LAUNCHER ccache)
    endif()
    if(NOT CMAKE_CXX_LINKER_LAUNCHER)
        set(CMAKE_CXX_LINKER_LAUNCHER ccache)
    endif()
    message(STATUS "ccache: using ccache")
else()
    message(STATUS "ccache: not found")
endif()
