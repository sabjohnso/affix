#
# ... Build script for affix
#

cmake_minimum_required( VERSION 3.1 )

project( AFFIX VERSION 0.2 LANGUAGES CXX )

option( BUILD_AFFIX_TESTING "Build the affix  tests" ON )
option( BUILD_AFFIX_DOCUMENTATION "Build the documentation for the affix library." ON )

list( APPEND CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )

set( CMAKE_CXX_STANDARD 14 )


include( GNUInstallDirs )



set( affix_version "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}" )
set( AFFIX_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/affix-${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
  CACHE PATH "Path for the installation of the affix header files" )

set( AFFIX_INSTALL_LIBDIR ${CMAKE_INSTALL_LIBDIR}/affix-${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR})
set( AFFIX_INSTALL_CONFIGDIR ${AFFIX_INSTALL_LIBDIR})


add_library( affix INTERFACE )
target_include_directories( affix INTERFACE
  $<BUILD_INTERFACE:${AFFIX_SOURCE_DIR}>
  $<BUILD_INTERFACE:${AFFIX_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${AFFIX_INSTALL_INCLUDEDIR}> )

add_library(affix::affix ALIAS affix)
  
  
add_subdirectory( affix )

install(
  TARGETS affix
  EXPORT affix_targets
  LIBRARY DESTINATION ${AFFIX_INSTALL_LIBDIR})

install(
  EXPORT affix_targets
  NAMESPACE affix::
  FILE affix-targets.cmake
  DESTINATION ${AFFIX_INSTALL_CONFIGDIR})

configure_file( affix-config.cmake.in affix-config.cmake @ONLY)
install(
  FILES ${AFFIX_BINARY_DIR}/affix-config.cmake
  DESTINATION ${AFFIX_INSTALL_CONFIGDIR})








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
