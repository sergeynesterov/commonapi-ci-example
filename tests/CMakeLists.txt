include( ${PROJECT_SOURCE_DIR}/cmake/GTest.cmake )
include( ${PROJECT_SOURCE_DIR}/cmake/DLT.cmake )
include( ${PROJECT_SOURCE_DIR}/cmake/CAPI.cmake )

add_gtest( NAME dummyTest SOURCES test.cpp )

target_include_directories( dummyTest SYSTEM PRIVATE ${DLT_INCLUDE_DIRS} )
target_compile_options( dummyTest PRIVATE ${DLT_CFLAGS} ${DLT_CFLAGS_OTHER} )
target_link_libraries( dummyTest PRIVATE -Wl,-rpath=${DLT_LIBRARY_DIRS} ${DLT_LDFLAGS} ${DLT_LDFLAGS_OTHER} )
