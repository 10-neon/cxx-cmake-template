function(include_directoried_default TARGET_NAME)
    target_include_directories(${TARGET_NAME} PRIVATE
        ${PROJECT_SOURCE_DIR}/include
        ${PROJECT_SOURCE_DIR}/src
        ${CMAKE_BINARY_DIR}/include
    )
endfunction()
