include(FetchContent)

FetchContent_GetProperties(doxygen-awesome-css)
if (NOT doxygen-awesome-css_POPULATED)
    message(STATUS "doxygen: fetching doxygen-awesome-css")
    FetchContent_Declare(
            doxygen-awesome-css
            URL https://github.com/jothepro/doxygen-awesome-css/archive/refs/heads/main.zip
    )
    FetchContent_MakeAvailable(doxygen-awesome-css)
endif()

FetchContent_GetProperties(doxygen-awesome-css SOURCE_DIR AWESOME_CSS_DIR)

find_package(Doxygen)

if(DOXYGEN_FOUND)
    set(DOXYGEN_GENERATE_TREEVIEW YES)
    set(DOXYGEN_DISABLE_INDEX NO)
    set(DOXYGEN_FULL_SIDEBAR NO)
    set(DOXYGEN_CREATE_SUBDIRS YES)
    if(Doxygen_dot_FOUND)
        set(DOXYGEN_DOT_IMAGE_FORMAT svg)
        set(DOXYGEN_DOT_TRANSPARENT YES)
    endif()
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_GENERATE_TREEVIEW YES)
    set(DOXYGEN_HTML_EXTRA_STYLESHEET
            ${AWESOME_CSS_DIR}/doxygen-awesome.css
            ${AWESOME_CSS_DIR}/doxygen-awesome-sidebar-only.css
            ${AWESOME_CSS_DIR}/doxygen-awesome-sidebar-only-darkmode-toggle.css)
    set(DOXYGEN_HTML_EXTRA_FILES
            ${AWESOME_CSS_DIR}/doxygen-awesome-darkmode-toggle.js
            ${AWESOME_CSS_DIR}/doxygen-awesome-interactive-toc.js
            ${AWESOME_CSS_DIR}/doxygen-awesome-tabs.js)
    message(STATUS "doxygen: using ${AWESOME_CSS_DIR}/doxygen-awesome.css")
    set(DOXYGEN_INTERNAL_DOCS YES)
    set(DOXYGEN_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/docs)
    set(DOXYGEN_SOURCE_BROWSER YES)
    set(DOXYGEN_EXAMPLE_PATH ${PROJECT_SOURCE_DIR}/example)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE ${PROJECT_SOURCE_DIR}/README.md)

# 生成 Doxygen 文档
    doxygen_add_docs(
            docs
            ${PROJECT_SOURCE_DIR}/app
            ${PROJECT_SOURCE_DIR}/src
            ${PROJECT_SOURCE_DIR}/include
            ${PROJECT_SOURCE_DIR}/docs
            ${PROJECT_SOURCE_DIR}/README.md
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/docs)
    message(STATUS "doxygen: added docs target")
endif()
