set( DLT_VERSION 2.17.0 )

set( DLT_DIR ${PROJECT_SOURCE_DIR}/external-deps/dlt )
set( DLT_ROOT ${PROJECT_SOURCE_DIR}/external-deps/${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}-${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_BUILD_TYPE} )

set( ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${DLT_ROOT}/lib/pkgconfig" )

configure_file( ${PROJECT_SOURCE_DIR}/cmake/FIX_CLANG_ERRORS.cmake.in ${DLT_DIR}/FIX_CLANG_ERRORS.cmake )
configure_file( ${PROJECT_SOURCE_DIR}/cmake/DLT.cmake.in ${DLT_DIR}/CMakeLists.txt )
execute_process( COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY "${DLT_DIR}" )
execute_process( COMMAND "${CMAKE_COMMAND}" --build . WORKING_DIRECTORY "${DLT_DIR}" )

find_package( PkgConfig REQUIRED )
pkg_check_modules( DLT REQUIRED automotive-dlt=${DLT_VERSION} )
