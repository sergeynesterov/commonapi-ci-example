set( CAPI_VERSION 3.1.12 )

set( VSOMEIP_VERSION 2.7.0 )
set( DBUS_VERSION 1.10.24 )

set( CAPI_DIR ${PROJECT_SOURCE_DIR}/external-deps/capi )
set( CAPI_ROOT ${PROJECT_SOURCE_DIR}/external-deps/${CMAKE_CXX_COMPILER_ID} )

set( ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${CAPI_ROOT}/lib/pkgconfig" )

include( ProcessorCount )
ProcessorCount( NPROC )

configure_file( ${PROJECT_SOURCE_DIR}/cmake/FIX_WRONG_DLT_CONFIG.cmake.in ${CAPI_DIR}/FIX_WRONG_DLT_CONFIG.cmake )
configure_file( ${PROJECT_SOURCE_DIR}/cmake/CAPI.cmake.in ${CAPI_DIR}/CMakeLists.txt )
execute_process( COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY "${CAPI_DIR}" )
execute_process( COMMAND "${CMAKE_COMMAND}" --build . -- -j${NPROC} WORKING_DIRECTORY "${CAPI_DIR}" )

find_package( CommonAPI REQUIRED ${CAPI_VERSION} )
find_package( CommonAPI-DBus REQUIRED ${CAPI_VERSION} )
find_package( CommonAPI-SomeIP REQUIRED ${CAPI_VERSION} )
