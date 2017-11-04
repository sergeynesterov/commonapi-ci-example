set( CAPI_VERSION 3.1.12 )

set( VSOMEIP_VERSION 2.7.0 )
set( DBUS_VERSION 1.10.24 )

set( CAPI_DIR ${PROJECT_SOURCE_DIR}/external-deps/capi )
set( CAPI_ROOT ${PROJECT_SOURCE_DIR}/external-deps/${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}-${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_BUILD_TYPE} )

set( ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${CAPI_ROOT}/lib/pkgconfig" )

include( ProcessorCount )
ProcessorCount( NPROC )
message( "Building in ${NPROC} threads" )

configure_file( ${PROJECT_SOURCE_DIR}/cmake/FIX_WRONG_DLT_CONFIG.cmake.in ${CAPI_DIR}/FIX_WRONG_DLT_CONFIG.cmake )
configure_file( ${PROJECT_SOURCE_DIR}/cmake/CAPI.cmake.in ${CAPI_DIR}/CMakeLists.txt )
execute_process( COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY "${CAPI_DIR}" )
#execute_process( COMMAND "${CMAKE_COMMAND}" --build . -- -j${NPROC} WORKING_DIRECTORY "${CAPI_DIR}" )
execute_process( COMMAND "${CMAKE_COMMAND}" --build . -- -j8 WORKING_DIRECTORY "${CAPI_DIR}" )

find_package( CommonAPI ${CAPI_VERSION} EXACT REQUIRED )
find_package( CommonAPI-DBus ${CAPI_VERSION} EXACT REQUIRED )
find_package( CommonAPI-SomeIP ${CAPI_VERSION} EXACT REQUIRED )
