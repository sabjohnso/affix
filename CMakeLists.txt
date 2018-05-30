#
# ... Build script for affix
#

cmake_minimum_required( VERSION 3.1 )

project( AFFIX )

option( BUILD_AFFIX_TESTING "Build the affix  tests" ON )
option( ACTIVATE_VERSION_ON_INSTALLATION "Link the unversioned include directory to this version." ON )

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )

set( CMAKE_CXX_STANDARD 14 )

include( affix_version )
set( affix_version "${AFFIX_MAJOR_VERSION}.${AFFIX_MINOR_VERSION}.${AFFIX_PATCH_VERSION}" )

if( NOT AFFIX_INSTALL_INCLUDE_DIR )
  set( AFFIX_INSTALL_INCLUDE_DIR
    include/affix-${AFFIX_MAJOR_VERSION}.${AFFIX_MINOR_VERSION}/affix
    CACHE
    PATH
    "Path for the installation of the affix header files" )
endif( NOT AFFIX_INSTALL_INCLUDE_DIR )


if( NOT AFFIX_INSTALL_DOC_DIR )
  set( AFFIX_INSTALL_DOC_DIR
    share/doc/affix-${AFFIX_MAJOR_VERSION}-${AFFIX_MINOR_VERSION}
    CACHE
    PATH
    "Path for the installation of the affix documentation" )
endif( NOT AFFIX_INSTALL_DOC_DIR )




include_directories( 
  ${AFFIX_SOURCE_DIR}
  ${AFFIX_BINARY_DIR})


add_subdirectory( affix )



if( BUILD_AFFIX_TESTING )
  enable_testing()
  add_subdirectory( affix_testing )
endif( BUILD_AFFIX_TESTING )


install (SCRIPT cmake/post_install.cmake)


# end of build definition for affix
