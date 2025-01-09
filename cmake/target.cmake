include(coverage)

function(include_directories_default TARGET_NAME)
    target_include_directories(${TARGET_NAME} PRIVATE
            ${PROJECT_SOURCE_DIR}/include
            ${PROJECT_SOURCE_DIR}/src
            ${CMAKE_BINARY_DIR}/include
    )
endfunction()

function(create_test TEST_NAME)
    add_library(${TEST_NAME}_obj OBJECT ${TEST_NAME}.cpp)
    add_executable(${TEST_NAME} $<TARGET_OBJECTS:${TEST_NAME}_obj>)
    include_directories_default(${TEST_NAME}_obj)
    target_include_directories(${TEST_NAME}_obj PRIVATE
            ${Catch2_SOURCE_DIR}/src
            ${Catch2_BINARY_DIR}/generated-includes)

    add_gcov_compiler_flags(${TEST_NAME}_obj)
    add_gcov_compiler_flags(${TEST_NAME})
    link_gcov(${TEST_NAME})
    target_link_libraries(${TEST_NAME} PRIVATE Catch2::Catch2WithMain)
    catch_discover_tests(${TEST_NAME})
    add_dependencies(tests ${TEST_NAME})
endfunction()
