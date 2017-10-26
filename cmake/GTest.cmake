set( GTEST_VERSION 1.8.0 )
set( GTEST_DIR ${PROJECT_SOURCE_DIR}/external-deps/googletest )

if( ( NOT DEFINED ${GTEST_ROOT} ) OR ( NOT GTEST_ROOT ) )
   set( GTEST_ROOT ${PROJECT_SOURCE_DIR}/external-deps/${CMAKE_CXX_COMPILER_ID} )
endif()

configure_file( ${PROJECT_SOURCE_DIR}/cmake/GTest.cmake.in ${GTEST_DIR}/CMakeLists.txt )
execute_process( COMMAND "${CMAKE_COMMAND}" -DGTEST_ROOT=${GTEST_ROOT} -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY "${GTEST_DIR}" )
execute_process( COMMAND "${CMAKE_COMMAND}" --build . WORKING_DIRECTORY "${GTEST_DIR}" )

# Prevent GoogleTest from overriding our compiler/linker options
# when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

find_package( GTest ${GTEST_VERSION} REQUIRED )

set( THREADS_PREFER_PTHREAD_FLAG ON )
find_package( Threads REQUIRED )

function( add_gtest )
   set( options )
   set( oneValueArgs NAME )
   set( multiValueArgs SOURCES ARGS )
   cmake_parse_arguments( TEST "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

   add_executable( ${TEST_NAME} ${TEST_SOURCES} )
   target_include_directories( ${TEST_NAME} SYSTEM PRIVATE ${GTEST_INCLUDE_DIRS} )
   target_link_libraries( ${TEST_NAME} PRIVATE ${GTEST_BOTH_LIBRARIES} PRIVATE Threads::Threads )
   GTEST_ADD_TESTS( ${TEST_NAME} "${TEST_AGRS}" ${TEST_SOURCES} )
endfunction()
