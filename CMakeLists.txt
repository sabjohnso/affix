#
# ... Build script for affix
#

cmake_minimum_required( VERSION 3.1 )

project( AFFIX )

option( BUILD_AFFIX_TESTING "Build the affix  tests" ON )
option( ACTIVATE_VERSION_ON_INSTALLATION "Link the unversioned include directory to this version." ON )
option( BUILD_AFFIX_DOCUMENTATION "Build the documentation for the affix library." ON )

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







include_directories( 
  ${AFFIX_SOURCE_DIR}
  ${AFFIX_BINARY_DIR})


add_subdirectory( affix )


if( BUILD_AFFIX_TESTING )
  enable_testing()
  add_subdirectory( affix_testing )
endif( BUILD_AFFIX_TESTING )



if( BUILD_AFFIX_DOCUMENTATION )
  if( NOT AFFIX_INSTALL_DOC_DIR )
    set( AFFIX_INSTALL_DOC_DIR
      share/doc/affix-${AFFIX_MAJOR_VERSION}-${AFFIX_MINOR_VERSION}
      CACHE
      PATH
      "Path for the installation of the affix documentation" )
  endif( NOT AFFIX_INSTALL_DOC_DIR )

  if( NOT AFFIX_INSTALL_MAN_DIR )
    set( AFFIX_INSTALL_MAN_DIR
      share
      CACHE
      PATH
      "Path for the installation of the affix manual pages" )
  endif( NOT AFFIX_INSTALL_MAN_DIR )
  
  find_package( Doxygen REQUIRED  )
  configure_file( Doxyfile.in Doxyfile )
  add_custom_command(
    OUTPUT ${AFFIX_BINARY_DIR}/affix_doxygen.log
    COMMAND "${DOXYGEN_EXECUTABLE}" "${AFFIX_BINARY_DIR}/Doxyfile" > affix_doxygen.log
    MAIN_DEPENDENCY "${AFFIX_BINARY_DIR}/Doxyfile"
    DEPENDS ${AFFIX_SOURCE_DIR}/affix/affix.hpp
    WORKING_DIRECTORY ${AFFIX_BINARY_DIR} )

  add_custom_target(
    affix_documentation ALL
    DEPENDS ${AFFIX_BINARY_DIR}/affix_doxygen.log )
  
  install( DIRECTORY ${AFFIX_BINARY_DIR}/doc/html DESTINATION ${AFFIX_INSTALL_DOC_DIR})
  install( DIRECTORY ${AFFIX_BINARY_DIR}/doc/man DESTINATION ${AFFIX_INSTALL_MAN_DIR})
endif( BUILD_AFFIX_DOCUMENTATION )

install( SCRIPT cmake/post_install.cmake )

# end of build definition for affix
