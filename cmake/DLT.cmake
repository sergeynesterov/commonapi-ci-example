set( DLT_VERSION 2.17.0 )

set( DLT_DIR ${PROJECT_SOURCE_DIR}/external-deps/dlt )
set( DLT_ROOT ${PROJECT_SOURCE_DIR}/external-deps/${CMAKE_CXX_COMPILER_ID} )

# Download and compile googletest at configure time
configure_file( ${PROJECT_SOURCE_DIR}/cmake/DLT.cmake.in ${DLT_DIR}/CMakeLists.txt )
execute_process(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
   WORKING_DIRECTORY "${DLT_DIR}" )
execute_process(COMMAND "${CMAKE_COMMAND}" --build .
   WORKING_DIRECTORY "${DLT_DIR}" )

set( ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${DLT_ROOT}/lib/pkgconfig" )
find_package( PkgConfig )

pkg_check_modules( DLT REQUIRED automotive-dlt=${DLT_VERSION} )
