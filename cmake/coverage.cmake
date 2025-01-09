
find_program(GCOVR_PATH gcovr REQUIRED)

function(create_coverage_targets)
    add_custom_target(coverage-clean
            COMMAND cmake -B ${CMAKE_BINARY_DIR} -P ${CMAKE_SOURCE_DIR}/cmake/coverage-cleanup.cmake)
    add_custom_target(coverage
            COMMAND ctest --test-dir ${CMAKE_BINARY_DIR}
            COMMAND ${GCOVR_PATH}
            --config ${CMAKE_SOURCE_DIR}/gcovr.cfg
            --root ${CMAKE_SOURCE_DIR}
            --object-directory=${CMAKE_BINARY_DIR}
            --verbose
            --txt -
            ${CMAKE_BINARY_DIR}
            COMMAND ${GCOVR_PATH}
            --config ${CMAKE_SOURCE_DIR}/gcovr.cfg
            --root ${CMAKE_SOURCE_DIR}
            --object-directory=${CMAKE_BINARY_DIR}
            --verbose
            --xml ${CMAKE_BINARY_DIR}/gcov/cobertura-coverage.xml
            --html ${CMAKE_BINARY_DIR}/gcov/cobertura-coverage.html
            ${CMAKE_BINARY_DIR}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/gcov)
    add_dependencies(coverage coverage-clean tests)
endfunction()

set(GCOV_COMPILER_FLAGS -g3 -O0 --coverage)

function(add_gcov_compiler_flags TARGET)
    target_compile_options(${TARGET} PUBLIC ${GCOV_COMPILER_FLAGS})
    message(STATUS "[${TARGET}] gcov compiler flags: ${GCOV_COMPILER_FLAGS}")
endfunction()

function(link_gcov TARGET)
    target_link_options(${TARGET} PUBLIC ${GCOV_COMPILER_FLAGS})
    target_link_options(${TARGET} PUBLIC -fprofile-arcs -ftest-coverage)
endfunction()
