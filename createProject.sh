#**************************************************
# A script to generate C++ project skeletons
# https://github.com/vincent-picaud/CMakeScript
#**************************************************

if [ "$#" -ne 1 ]; then
    echo -e "\\n\\nUsage is:\\n" $0 " project_name\\n"
    exit -1
fi

echo -e "Create C++ project skeleton: $1"

project_name="$(basename "$1" | tr -st ' ' '_' )"
project_path="$(dirname "$1")"

#**************************************************
# Create all CMakeLists.txt files
#**************************************************
#

current_file="${project_path}/${project_name}/CMakeLists.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#**************************************************
# A script to generate C++ project skeletons
# https://github.com/vincent-picaud/CMakeScript
#**************************************************

#==================================================
# Automatically generated, but never overwritten
#
# Adapted from: https://github.com/bast/cmake-example/blob/master/CMakeLists.txt
#==================================================
#
cmake_minimum_required(VERSION 3.0)
project(OUR_PROJECT_NAME LANGUAGES CXX)
enable_language(Fortran C CXX)

# OUR_PROJECT_NAME version
#
set(OUR_PROJECT_NAME_VERSION_MAJOR 0)
set(OUR_PROJECT_NAME_VERSION_MINOR 1)
set(OUR_PROJECT_NAME_VERSION_PATCH 0)
set(OUR_PROJECT_NAME_VERSION ${OUR_PROJECT_NAME_VERSION_MAJOR}.${OUR_PROJECT_NAME_VERSION_MINOR}.${OUR_PROJECT_NAME_VERSION_PATCH})

# OPTIONS
#
option(OUR_PROJECT_NAME_USE_GTEST "Use GTest (fixme turn off if you want to install)" ON)

option(OUR_PROJECT_NAME_USE_QT5 "Use QT5" OFF)
option(OUR_PROJECT_NAME_USE_QWT "Use QWt" OFF)
option(OUR_PROJECT_NAME_USE_OpenMP "Use OpenMP" OFF)
option(OUR_PROJECT_NAME_USE_BOOST "Use BOOST" OFF)
option(OUR_PROJECT_NAME_USE_BLAS "Use BLAS" OFF)
option(OUR_PROJECT_NAME_USE_LAPACK "Use LAPACK" OFF)

# Location of additional cmake modules
#
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${PROJECT_SOURCE_DIR}/cmake
    )

# Guard against in-source builds and bad build-type strings
#
include(ConfigSafeGuards)

# Example how to set c++ compiler flags for GNU
#
if((CMAKE_CXX_COMPILER_ID MATCHES GNU) OR (CMAKE_CXX_COMPILER_ID MATCHES Clang))
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} -std=c++14 -pthread -Wall -Wextra -Wno-unknown-pragmas -Wno-sign-compare -Woverloaded-virtual -Wwrite-strings -Wno-unused")
    set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g3")
    set(CMAKE_CXX_FLAGS_RELEASE "-O2 -DNDEBUG")
    set(CMAKE_CXX_FLAGS_COVERAGE "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage")
endif()

#--------------------------------------------------
# Explore sub-directories
#--------------------------------------------------
#

# Our OUR_PROJECT_NAME library build
#
add_subdirectory(${PROJECT_SOURCE_DIR}/OUR_PROJECT_NAME/)

# Our OUR_PROJECT_NAME testing framework (gtest)
#
if(${OUR_PROJECT_NAME_USE_GTEST})
include(CTest)
enable_testing()
include(ConfigGTest)

add_subdirectory(${PROJECT_SOURCE_DIR}/test/)
endif()

# Our OUR_PROJECT_NAME examples build
#
add_subdirectory(${PROJECT_SOURCE_DIR}/examples/)

# Our OUR_PROJECT_NAME executables build
#
add_subdirectory(${PROJECT_SOURCE_DIR}/bin/)

# Our OUR_PROJECT_NAME doxygen doc build
#
add_subdirectory(${PROJECT_SOURCE_DIR}/doc/doxygen/)

#--------------------------------------
# Export and install
#--------------------------------------

# File generation
#--------------------------------------------------
#

# ConfigVersion generation
# From CMake doc: http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html
#
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/OUR_PROJECT_NAMEConfigVersion.cmake
  VERSION ${OUR_PROJECT_NAME_VERSION}
  COMPATIBILITY AnyNewerVersion
)

# Config generation
#
configure_file(${PROJECT_SOURCE_DIR}/cmake/OUR_PROJECT_NAMEConfig.cmake.in
   "${CMAKE_CURRENT_BINARY_DIR}/OUR_PROJECT_NAMEConfig.cmake" 
   COPYONLY)


# Export for build-tree direct usage
#--------------------------------------------------
#
export(EXPORT OUR_PROJECT_NAMETargets
   FILE "${CMAKE_CURRENT_BINARY_DIR}/OUR_PROJECT_NAMETargets.cmake"
)

# Global export in the Package Registry 
#--------------------------------------------------
#
export(PACKAGE OUR_PROJECT_NAME)

# Install-Export for usage after project installation
#--------------------------------------------------
#
set(ConfigPackageLocation lib/cmake/OUR_PROJECT_NAME)
install(EXPORT OUR_PROJECT_NAMETargets
  FILE
    OUR_PROJECT_NAMETargets.cmake
  DESTINATION
    ${ConfigPackageLocation}
)
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/OUR_PROJECT_NAMEConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/OUR_PROJECT_NAMEConfigVersion.cmake"
  DESTINATION
    ${ConfigPackageLocation}
)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/${project_name}/CMakeLists.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Build OUR_PROJECT_NAME library
# Automatically generated, but not overwritten
#==================================================
#
#--------------------------------------------------
# Configuration file config.hpp
#--------------------------------------------------
#

# Get git hash
#
include(ConfigGitRevision)

# Configure header file
#
configure_file(
    ${PROJECT_SOURCE_DIR}/cmake/config.hpp.in
    ${PROJECT_BINARY_DIR}/OUR_PROJECT_NAME/config.hpp
    @ONLY)


#--------------------------------------------------
# Qt option is ON
#--------------------------------------------------

if(${OUR_PROJECT_NAME_USE_QT5})

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
#
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

endif()

#--------------------------------------------------
# Collect files and define target for the library
#--------------------------------------------------

# Collect files
# 
file(GLOB_RECURSE OUR_PROJECT_NAME_LIB_SOURCE_CPP 
     ${PROJECT_SOURCE_DIR}/OUR_PROJECT_NAME *.cpp)
file(GLOB_RECURSE OUR_PROJECT_NAME_LIB_SOURCE_HPP 
     ${PROJECT_SOURCE_DIR}/OUR_PROJECT_NAME *.hpp)

# Add library target with its dependencies
#
add_library(OUR_PROJECT_NAME SHARED ${OUR_PROJECT_NAME_LIB_SOURCE_CPP} ${OUR_PROJECT_NAME_LIB_SOURCE_HPP} config.hpp)

#--------------------------------------------------
# Header files
#--------------------------------------------------
#

# Location of header files
#
# CAVEAT: a priori must stay synchronized with target_include_directories(...)
#
include_directories(
    # search file in source directories
    ${PROJECT_SOURCE_DIR}/
    # otherwise try in the binary directory 
    # (to include the generated config.hpp for instance)
    ${PROJECT_BINARY_DIR}/)

# Here we define the include paths that will be used by our clients.
# see: http://www.cmake.org/cmake/help/v3.0/command/target_include_directories.html
# 
# CAVEAT: a priori must stay synchronized with include_directory(...)
#
target_include_directories(OUR_PROJECT_NAME PUBLIC
	$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/>
	$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/>
	$<INSTALL_INTERFACE:include/>)

# Library version
# http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html
#
set_property(TARGET OUR_PROJECT_NAME PROPERTY VERSION ${OUR_PROJECT_NAME_VERSION})
set_property(TARGET OUR_PROJECT_NAME PROPERTY SOVERSION ${OUR_PROJECT_NAME_MAJOR_VERSION})
set_property(TARGET OUR_PROJECT_NAME PROPERTY INTERFACE_OUR_PROJECT_NAME_MAJOR_VERSION ${OUR_PROJECT_NAME_MAJOR_VERSION})
set_property(TARGET OUR_PROJECT_NAME APPEND PROPERTY COMPATIBLE_INTERFACE_STRING "${OUR_PROJECT_NAME_MAJOR_VERSION}")

set_target_properties(OUR_PROJECT_NAME PROPERTIES LINKER_LANGUAGE CXX)

#--------------------------------------------------
# Include dependencies
#--------------------------------------------------
# You can add/remove what you need in the cmake/OUR_PROJECT_NAMEDependencies.cmake file
#
include(${PROJECT_SOURCE_DIR}/cmake/OUR_PROJECT_NAMEDependencies.cmake)

#--------------------------------------
# Installation
#--------------------------------------

# Target properties
# Commented because useless: does not respect directory hierarchy
# set_target_properties(OUR_PROJECT_NAME 
#                       PROPERTIES PUBLIC_HEADER "${OUR_PROJECT_NAME_LIB_SOURCE_HPP}")

# Install library & header file
install(TARGETS OUR_PROJECT_NAME 
        # IMPORTANT: Add the OUR_PROJECT_NAME library to the "export-set"
        EXPORT OUR_PROJECT_NAMETargets
        LIBRARY DESTINATION lib/OUR_PROJECT_NAME COMPONENT shlib
        ARCHIVE DESTINATION lib/OUR_PROJECT_NAME
        RUNTIME DESTINATION bin/OUR_PROJECT_NAME COMPONENT bin
        # Does not respect directory hierarchy !?!
        # PUBLIC_HEADER DESTINATION include/OUR_PROJECT_NAME
)

# -> Manual installation of hpp files
#
install(DIRECTORY ${PROJECT_SOURCE_DIR}/OUR_PROJECT_NAME
        DESTINATION include
        FILES_MATCHING PATTERN "*.hpp")

install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/config.hpp"
        DESTINATION
        include/OUR_PROJECT_NAME
)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/bin/CMakeLists.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Build OUR_PROJECT_NAME executables
# Automatically generated, but not overwritten
#==================================================
#

#
# Binary dir (bin/) does not preserve directory structure
#==================================================

# Collect files
# --------------------------------------------------
#
file(GLOB_RECURSE ALL_SOURCES_CPP *.cpp)

# For each file
# --------------------------------------------------
#
foreach(ONE_SOURCE_CPP ${ALL_SOURCES_CPP})

# Build it!
#
get_filename_component(ONE_SOURCE_EXEC ${ONE_SOURCE_CPP} NAME_WE)

# Avoid name collision 
#
set(TARGET_NAME OUR_PROJECT_NAME_Bin_${ONE_SOURCE_EXEC})

add_executable(${TARGET_NAME} ${ONE_SOURCE_CPP})
set_target_properties(${TARGET_NAME} PROPERTIES OUTPUT_NAME ${ONE_SOURCE_EXEC}) 
target_link_libraries(${TARGET_NAME} OUR_PROJECT_NAME)

install(TARGETS ${TARGET_NAME} EXPORT OUR_PROJECT_NAMETargets RUNTIME DESTINATION bin)
endforeach()

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/examples/CMakeLists.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# OUR_PROJECT_NAME executables
# Automatically generated, but not overwritten
#==================================================

#
# Examples -> one need to preserve directory structure 
#==================================================

# Collect files
# --------------------------------------------------
# Use relative path to be able to copy binary file into examples/${ONE_SOURCE_RELATIVE_DIR}/
#
file(GLOB_RECURSE ALL_SOURCES_CPP RELATIVE ${PROJECT_SOURCE_DIR}/examples *.cpp)

# For each executable
# --------------------------------------------------
#
foreach(ONE_SOURCE_CPP ${ALL_SOURCES_CPP})

  # Build it!
  #
  get_filename_component(ONE_SOURCE_EXEC ${ONE_SOURCE_CPP} NAME_WE)

  # Avoid name collision 
  #
  set(TARGET_NAME OUR_PROJECT_NAME_Examples_${ONE_SOURCE_EXEC})

  add_executable(${TARGET_NAME} ${ONE_SOURCE_CPP})
  set_target_properties(${TARGET_NAME} PROPERTIES OUTPUT_NAME ${ONE_SOURCE_EXEC}) 
  target_link_libraries(${TARGET_NAME} OUR_PROJECT_NAME)

  # For the moment examples are NOT installed
  # -> but if required this should look like:
  #   (in order to preserve directory hierarchy)
  #
  # get_filename_component(ONE_SOURCE_RELATIVE_DIR ${ONE_SOURCE_CPP} DIRECTORY)
  # install(FILE ${TARGET_NAME} DESTINATION examples/${ONE_SOURCE_RELATIVE_DIR})
  
endforeach()


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/doc/doxygen/CMakeLists.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# OUR_PROJECT_NAME Doxygen "doc" target
# Automatically generated, but never overwritten
#==================================================
#

# Find doxygen
#--------------------------------------------------

find_package(Doxygen)
if (NOT DOXYGEN_FOUND)
    message(FATAL_ERROR "Doxygen is needed to build the documentation")
endif()

# Configure the doxyfile template 
#--------------------------------------------------

configure_file(${PROJECT_SOURCE_DIR}/doc/doxygen/doxyfile.in ${PROJECT_BINARY_DIR}/doc/doxygen/doxyfile @ONLY IMMEDIATE)

# Add a custom target to run Doxygen when ever the project is built
#--------------------------------------------------
#   If you do want the documentation to be generated EVERY time you build the project 
#   replace add_custom_target(doc...) by add_custom_target(doc ALL...)

# CAVEAT: in case of *super-project* build we define a OUR_PROJECT_NAME_doc target
#         instead of the usual "doc" one to avoid name collision
# 
if(${PROJECT_SOURCE_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
   add_custom_target(doc 
      	             COMMAND ${DOXYGEN_EXECUTABLE} ${PROJECT_BINARY_DIR}/doc/doxygen/doxyfile
   		     SOURCES ${PROJECT_BINARY_DIR}/doc/doxygen/doxyfile)
else()
   add_custom_target(OUR_PROJECT_NAME_doc 
   	             COMMAND ${DOXYGEN_EXECUTABLE} ${PROJECT_BINARY_DIR}/doc/doxygen/doxyfile
   		     SOURCES ${PROJECT_BINARY_DIR}/doc/doxygen/doxyfile)
endif()

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/test/CMakeLists.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# OUR_PROJECT_NAME unit tests
# Automatically generated, but not overwritten
#==================================================
#

# Setup
#--------------------------------------------------

find_package(Threads REQUIRED)

# Generate tests and associated targets
#--------------------------------------------------
file(GLOB_RECURSE ALL_TESTS_CPP *.cpp)

foreach(ONE_TEST_CPP ${ALL_TESTS_CPP})
   # Build it!
   #
   get_filename_component(ONE_TEST_EXEC ${ONE_TEST_CPP} NAME_WE)

   # Avoid name collision 
   #
   set(TARGET_NAME OUR_PROJECT_NAME_Test_${ONE_TEST_EXEC})

   add_executable(${TARGET_NAME} ${ONE_TEST_CPP})
   set_target_properties(${TARGET_NAME} PROPERTIES OUTPUT_NAME ${ONE_TEST_EXEC}) 
   target_link_libraries(${TARGET_NAME} 
                         OUR_PROJECT_NAME
                         gtest gmock_main
                         ${CMAKE_THREAD_LIBS_INIT})
   # Add Test
   add_test(${TARGET_NAME} ${ONE_TEST_EXEC})
endforeach()


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************
# Create Doc stuff
#**************************************************
#
current_file="${project_path}/${project_name}/doc/doxygen/doxyfile.in"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

PROJECT_NAME           = @PROJECT_NAME@
PROJECT_NUMBER         = @PROJECT_VERSION@

CITE_BIB_FILES         = @PROJECT_SOURCE_DIR@/doc/@PROJECT_NAME@_bibliography.bib

WARN_LOGFILE           = doxygenError.txt

INPUT                  = @PROJECT_SOURCE_DIR@/@PROJECT_NAME@ \
                         @PROJECT_SOURCE_DIR@/examples \
                         @PROJECT_SOURCE_DIR@/bin \
                         @PROJECT_SOURCE_DIR@/test

FILE_PATTERNS          = *.hpp *.cpp
RECURSIVE              = YES

EXCLUDE_PATTERNS       =  */moc_/* */_automoc/*
EXAMPLE_PATH           = @PROJECT_SOURCE_DIR@
EXAMPLE_PATTERNS       = *.cpp
EXAMPLE_RECURSIVE      = YES

IMAGE_PATH             = @PROJECT_SOURCE_DIR@/doc/figures/

EXTRA_PACKAGES         = mathtools \
                         amsfonts \
                         stmaryrd
			 
PREDEFINED             = DOXYGEN_DOC

//GO.SYSIN DD PRIVATE_DD_TAG
#sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# CAVEAT: Doxygen update doxyfile.in
#
#doxygen -u "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/doc/${project_name}_bibliography.bib"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

%==================================================
% OUR_PROJECT_NAME bibliography
% Automatically generated, but never overwritten
%==================================================
%
@Article{Heesch2008,
  Title                    = {Doxygen: Source code documentation generator tool},
  Author                   = {van Heesch, Dimitri},
  Journal                  = {URL: http://www.doxygen.org},
  Year                     = {2008}
}

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#==================================================
# OUR_PROJECT_NAME/doc/figures subdirectory
#==================================================
#
current_file="${project_path}/${project_name}/doc/figures/readme.txt"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

Put your figures here (one_figure.png file for instance)

They can be included in the doxygen doc with:

/**
 * @image html figures/one_figure.png
 */

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************
# Create the OUR_PROJECT_NAME/cmake/ files.
#**************************************************
#
current_file="${project_path}/${project_name}/cmake/${project_name}Config.cmake.in"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#==================================================
# see: http://www.cmake.org/cmake/help/v3.0/variable/CMAKE_CURRENT_LIST_DIR.html
#      http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html

include(CMakeFindDependencyMacro)

# If your project depends on project_A, uncomment me
#
# find_dependency(project_A)

include("${CMAKE_CURRENT_LIST_DIR}/OUR_PROJECT_NAMETargets.cmake")


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/FindQwt.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

# Qt Widgets for Technical Applications
# available at http://www.http://qwt.sourceforge.net/
#
# The module defines the following variables:
#  QWT_FOUND - the system has Qwt
#  QWT_INCLUDE_DIR - where to find qwt_plot.h
#  QWT_INCLUDE_DIRS - qwt includes
#  QWT_LIBRARY - where to find the Qwt library
#  QWT_LIBRARIES - aditional libraries
#  QWT_MAJOR_VERSION - major version
#  QWT_MINOR_VERSION - minor version
#  QWT_PATCH_VERSION - patch version
#  QWT_VERSION_STRING - version (ex. 5.2.1)
#  QWT_ROOT_DIR - root dir (ex. /usr/local)

#=============================================================================
# Copyright 2010-2013, Julien Schueller
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met: 
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution. 
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies, 
# either expressed or implied, of the FreeBSD Project.
#=============================================================================


find_path ( QWT_INCLUDE_DIR
  NAMES qwt_plot.h
  HINTS ${QT_INCLUDE_DIR} /usr/local/qwt/include
  PATH_SUFFIXES qwt qwt-qt3 qwt-qt4 qwt-qt5
)

set ( QWT_INCLUDE_DIRS ${QWT_INCLUDE_DIR} )

# version
set ( _VERSION_FILE ${QWT_INCLUDE_DIR}/qwt_global.h )
if ( EXISTS ${_VERSION_FILE} )
  file ( STRINGS ${_VERSION_FILE} _VERSION_LINE REGEX "define[ ]+QWT_VERSION_STR" )
  if ( _VERSION_LINE )
    string ( REGEX REPLACE ".*define[ ]+QWT_VERSION_STR[ ]+\"(.*)\".*" "\\1" QWT_VERSION_STRING "${_VERSION_LINE}" )
    string ( REGEX REPLACE "([0-9]+)\\.([0-9]+)\\.([0-9]+)" "\\1" QWT_MAJOR_VERSION "${QWT_VERSION_STRING}" )
    string ( REGEX REPLACE "([0-9]+)\\.([0-9]+)\\.([0-9]+)" "\\2" QWT_MINOR_VERSION "${QWT_VERSION_STRING}" )
    string ( REGEX REPLACE "([0-9]+)\\.([0-9]+)\\.([0-9]+)" "\\3" QWT_PATCH_VERSION "${QWT_VERSION_STRING}" )
  endif ()
endif ()


# check version
set ( _QWT_VERSION_MATCH TRUE )
if ( Qwt_FIND_VERSION AND QWT_VERSION_STRING )
  if ( Qwt_FIND_VERSION_EXACT )
    if ( NOT Qwt_FIND_VERSION VERSION_EQUAL QWT_VERSION_STRING )
      set ( _QWT_VERSION_MATCH FALSE )
    endif ()
  else ()
    if ( QWT_VERSION_STRING VERSION_LESS Qwt_FIND_VERSION )
      set ( _QWT_VERSION_MATCH FALSE )
    endif ()
  endif ()
endif ()


find_library ( QWT_LIBRARY
  NAMES qwt qwt-qt3 qwt-qt4 qwt-qt5
  HINTS ${QT_LIBRARY_DIR} /usr/local/qwt/lib
)

set ( QWT_LIBRARIES ${QWT_LIBRARY} )


# try to guess root dir from include dir
if ( QWT_INCLUDE_DIR )
  string ( REGEX REPLACE "(.*)/include.*" "\\1" QWT_ROOT_DIR ${QWT_INCLUDE_DIR} )
# try to guess root dir from library dir
elseif ( QWT_LIBRARY )
  string ( REGEX REPLACE "(.*)/lib[/|32|64].*" "\\1" QWT_ROOT_DIR ${QWT_LIBRARY} )
endif ()


# handle the QUIETLY and REQUIRED arguments
include ( FindPackageHandleStandardArgs )
if ( CMAKE_VERSION LESS 2.8.3 )
  find_package_handle_standard_args( Qwt DEFAULT_MSG QWT_LIBRARY QWT_INCLUDE_DIR _QWT_VERSION_MATCH )
else ()
  find_package_handle_standard_args( Qwt REQUIRED_VARS QWT_LIBRARY QWT_INCLUDE_DIR _QWT_VERSION_MATCH VERSION_VAR QWT_VERSION_STRING )
endif ()


mark_as_advanced (
  QWT_LIBRARY 
  QWT_LIBRARIES
  QWT_INCLUDE_DIR
  QWT_INCLUDE_DIRS
  QWT_MAJOR_VERSION
  QWT_MINOR_VERSION
  QWT_PATCH_VERSION
  QWT_VERSION_STRING
  QWT_ROOT_DIR
)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/${project_name}Dependencies.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# OUR_PROJECT_NAME dependencies
# Automatically generated, but not overwritten, 
#
# Modify me to add your project dependencies!
#==================================================

#--------------------------------------------------
# Dependency examples:
#--------------------------------------------------

# Sub-project dependence
#--------------------------------------------------
# For a "Super-Project" containing project_A and OUR_PROJECT_NAME,
# if OUR_PROJECT_NAME depends on project_A, simply uncomment me
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# if(NOT TARGET project_A)
# find_package(project_A CONFIG REQUIRED)
# if(NOT ${project_A_FOUND}) 
#    message(FATAL_ERROR "Did not found project_A module!")
# endif()
# endif()
# target_link_libraries(OUR_PROJECT_NAME project_A)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Note: the role of the if(NOT TARGET project_A) guard is only relevant in case
#       of super-project build where "project_A" is included by add_subdirectory
#       from a master CMakeLists.txt file.
#       In that case the file project_ATargets.cmake is not yet generated and
#       find_package(project_A CONFIG REQUIRED) would generate a "file not found" 
#       error. However the target project_A is already available.

# OpenMP
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if(${OUR_PROJECT_NAME_USE_OpenMP})
find_package(OpenMP REQUIRED)
if (OPENMP_FOUND)

set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${OpenMP_CXX_FLAGS}" PARENT_SCOPE )
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")

if(NOT MSVC)
target_link_libraries(OUR_PROJECT_NAME ${OpenMP_CXX_FLAGS})
endif()
endif()
endif()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# BOOST
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if(${OUR_PROJECT_NAME_USE_BOOST})
find_package(Boost REQUIRED COMPONENTS regex date_time filesystem system serialization) # Add any the module you need!
include_directories(${Boost_INCLUDE_DIRS})
target_link_libraries(OUR_PROJECT_NAME ${Boost_LIBRARIES})
endif()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# BLAS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if(${OUR_PROJECT_NAME_USE_BLAS})
enable_language(Fortran)
find_package(BLAS REQUIRED)
include_directories(${BLAS_INCLUDE_DIRS})
target_include_directories(OUR_PROJECT_NAME PUBLIC ${BLAS_INCLUDE_DIRS})
target_link_libraries(OUR_PROJECT_NAME ${BLAS_LIBRARIES})
endif()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# LAPACK
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if(${OUR_PROJECT_NAME_USE_LAPACK})
find_package(LAPACK REQUIRED)
include_directories(${LAPACK_INCLUDE_DIRS})
target_include_directories(OUR_PROJECT_NAME PUBLIC ${LAPACK_INCLUDE_DIRS})
endif()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Qt5
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# CAVEAT: OUR_PROJECT_NAME/CMakeLists.txt also contains
#
# if(${OUR_PROJECT_NAME_USE_QT5})
#   set(CMAKE_AUTOMOC ON)
#   set(CMAKE_INCLUDE_CURRENT_DIR ON)
#   set(CMAKE_POSITION_INDEPENDENT_CODE ON)
# endif()

#
if(${OUR_PROJECT_NAME_USE_QT5})

#
find_package(Qt5Core REQUIRED)
include_directories(${Qt5Core_INCLUDE_DIRS})
target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5Core_INCLUDE_DIRS})
get_target_property(QtCore_location Qt5::Core LOCATION)
#target_link_libraries(OUR_PROJECT_NAME ${Qt5Core_location})

#
find_package(Qt5Widgets REQUIRED)
include_directories(${Qt5Widgets_INCLUDE_DIRS})
target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5Widgets_INCLUDE_DIRS})
get_target_property(QtWidgets_location Qt5::Widgets LOCATION)
target_link_libraries(OUR_PROJECT_NAME ${Qt5Widgets_location} ${Qt5Core_location})

#
find_package(Qt5PrintSupport REQUIRED)
include_directories(${Qt5PrintSupport_INCLUDE_DIRS})
target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5PrintSupport_INCLUDE_DIRS})
get_target_property(QtPrintSupport_location Qt5::PrintSupport LOCATION)
target_link_libraries(OUR_PROJECT_NAME ${Qt5PrintSupport_location} ${Qt5Core_location})

#
# Add all the remaining QT modules you need here...
#

endif()


# Qwt
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

# CAVEAT: maybe you have to add your own FindQwt.cmake in 
#         the OUR_PROJECT_NAME/cmake directory
#         You can find one at:
#         http://www.cmake.org/Wiki/CMakeUserFindQwt
#         https://github.com/qgis/QGIS/blob/master/cmake/FindQwt.cmake

if(${OUR_PROJECT_NAME_USE_QWT})

find_package(Qwt REQUIRED)
include_directories(${QWT_INCLUDE_DIRS})
target_include_directories(OUR_PROJECT_NAME PUBLIC ${QWT_INCLUDE_DIRS})
target_link_libraries(OUR_PROJECT_NAME ${QWT_LIBRARIES} ${Qt5Widgets_LIBRARIES} ${Qt5Core_LIBRARIES})

endif()


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/ConfigGTest.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

# Detect if super project or not
#
if(${CMAKE_PROJECT_NAME} STREQUAL ${PROJECT_NAME}) 
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Stand-alone project
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# adapated from https://github.com/Crascit/DownloadProject/blob/master/CMakeLists.txt
# CAVEAT: use DownloadProject.cmake
#
if (CMAKE_VERSION VERSION_LESS 3.2)
    set(UPDATE_DISCONNECTED_IF_AVAILABLE "")
else()
    set(UPDATE_DISCONNECTED_IF_AVAILABLE "UPDATE_DISCONNECTED 1")
endif()

include(DownloadProject)
download_project(PROJ                googletest
                 GIT_REPOSITORY      https://github.com/google/googletest.git
                 GIT_TAG             master
                 ${UPDATE_DISCONNECTED_IF_AVAILABLE}
)

# Prevent GoogleTest from overriding our compiler/linker options
# when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})

# When using CMake 2.8.11 or later, header path dependencies
# are automatically added to the gtest and gmock targets.
# For earlier CMake versions, we have to explicitly add the
# required directories to the header search path ourselves.
if (CMAKE_VERSION VERSION_LESS 2.8.11)
    include_directories("${gtest_SOURCE_DIR}/include"
                        "${gmock_SOURCE_DIR}/include")
endif()

else(${CMAKE_PROJECT_NAME}=={PROJECT_NAME})
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Stand-alone project
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
  
endif(${CMAKE_PROJECT_NAME} STREQUAL ${PROJECT_NAME}) 

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/DownloadProject.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

# From https://github.com/Crascit/DownloadProject

# MODULE:   DownloadProject
#
# PROVIDES:
#   download_project( PROJ projectName
#                    [PREFIX prefixDir]
#                    [DOWNLOAD_DIR downloadDir]
#                    [SOURCE_DIR srcDir]
#                    [BINARY_DIR binDir]
#                    [QUIET]
#                    ...
#   )
#
#       Provides the ability to download and unpack a tarball, zip file, git repository,
#       etc. at configure time (i.e. when the cmake command is run). How the downloaded
#       and unpacked contents are used is up to the caller, but the motivating case is
#       to download source code which can then be included directly in the build with
#       add_subdirectory() after the call to download_project(). Source and build
#       directories are set up with this in mind.
#
#       The PROJ argument is required. The projectName value will be used to construct
#       the following variables upon exit (obviously replace projectName with its actual
#       value):
#
#           projectName_SOURCE_DIR
#           projectName_BINARY_DIR
#
#       The SOURCE_DIR and BINARY_DIR arguments are optional and would not typically
#       need to be provided. They can be specified if you want the downloaded source
#       and build directories to be located in a specific place. The contents of
#       projectName_SOURCE_DIR and projectName_BINARY_DIR will be populated with the
#       locations used whether you provide SOURCE_DIR/BINARY_DIR or not.
#
#       The DOWNLOAD_DIR argument does not normally need to be set. It controls the
#       location of the temporary CMake build used to perform the download.
#
#       The PREFIX argument can be provided to change the base location of the default
#       values of DOWNLOAD_DIR, SOURCE_DIR and BINARY_DIR. If all of those three arguments
#       are provided, then PREFIX will have no effect. The default value for PREFIX is
#       CMAKE_BINARY_DIR.
#
#       The QUIET option can be given if you do not want to show the output associated
#       with downloading the specified project.
#
#       In addition to the above, any other options are passed through unmodified to
#       ExternalProject_Add() to perform the actual download, patch and update steps.
#       The following ExternalProject_Add() options are explicitly prohibited (they
#       are reserved for use by the download_project() command):
#
#           CONFIGURE_COMMAND
#           BUILD_COMMAND
#           INSTALL_COMMAND
#           TEST_COMMAND
#
#       Only those ExternalProject_Add() arguments which relate to downloading, patching
#       and updating of the project sources are intended to be used. Also note that at
#       least one set of download-related arguments are required.
#
#       If using CMake 3.2 or later, the UPDATE_DISCONNECTED option can be used to
#       prevent a check at the remote end for changes every time CMake is run
#       after the first successful download. See the documentation of the ExternalProject
#       module for more information. It is likely you will want to use this option if it
#       is available to you.
#
# EXAMPLE USAGE:
#
#   include(download_project.cmake)
#   download_project(PROJ                googletest
#                    GIT_REPOSITORY      https://github.com/google/googletest.git
#                    GIT_TAG             master
#                    UPDATE_DISCONNECTED 1
#                    QUIET
#   )
#
#   add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})
#
#========================================================================================


set(_DownloadProjectDir "${CMAKE_CURRENT_LIST_DIR}")

include(CMakeParseArguments)

function(download_project)

    set(options QUIET)
    set(oneValueArgs
        PROJ
        PREFIX
        DOWNLOAD_DIR
        SOURCE_DIR
        BINARY_DIR
        # Prevent the following from being passed through
        CONFIGURE_COMMAND
        BUILD_COMMAND
        INSTALL_COMMAND
        TEST_COMMAND
    )
    set(multiValueArgs "")

    cmake_parse_arguments(DL_ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # Hide output if requested
    if (DL_ARGS_QUIET)
        set(OUTPUT_QUIET "OUTPUT_QUIET")
    else()
        unset(OUTPUT_QUIET)
        message(STATUS "Downloading/updating ${DL_ARGS_PROJ}")
    endif()

    # Set up where we will put our temporary CMakeLists.txt file and also
    # the base point below which the default source and binary dirs will be
    if (NOT DL_ARGS_PREFIX)
        set(DL_ARGS_PREFIX "${CMAKE_BINARY_DIR}")
    endif()
    if (NOT DL_ARGS_DOWNLOAD_DIR)
        set(DL_ARGS_DOWNLOAD_DIR "${DL_ARGS_PREFIX}/${DL_ARGS_PROJ}-download")
    endif()

    # Ensure the caller can know where to find the source and build directories
    if (NOT DL_ARGS_SOURCE_DIR)
        set(DL_ARGS_SOURCE_DIR "${DL_ARGS_PREFIX}/${DL_ARGS_PROJ}-src")
    endif()
    if (NOT DL_ARGS_BINARY_DIR)
        set(DL_ARGS_BINARY_DIR "${DL_ARGS_PREFIX}/${DL_ARGS_PROJ}-build")
    endif()
    set(${DL_ARGS_PROJ}_SOURCE_DIR "${DL_ARGS_SOURCE_DIR}" PARENT_SCOPE)
    set(${DL_ARGS_PROJ}_BINARY_DIR "${DL_ARGS_BINARY_DIR}" PARENT_SCOPE)

    # Create and build a separate CMake project to carry out the download.
    # If we've already previously done these steps, they will not cause
    # anything to be updated, so extra rebuilds of the project won't occur.
    configure_file("${_DownloadProjectDir}/DownloadProject.CMakeLists.cmake.in"
                   "${DL_ARGS_DOWNLOAD_DIR}/CMakeLists.txt")
    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
                    ${OUTPUT_QUIET}
                    WORKING_DIRECTORY "${DL_ARGS_DOWNLOAD_DIR}"
    )
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
                    ${OUTPUT_QUIET}
                    WORKING_DIRECTORY "${DL_ARGS_DOWNLOAD_DIR}"
    )

endfunction()

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/DownloadProject.CMakeLists.cmake.in"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

cmake_minimum_required(VERSION 2.8.2)

project(${DL_ARGS_PROJ}-download NONE)

include(ExternalProject)
ExternalProject_Add(${DL_ARGS_PROJ}-download
                    ${DL_ARGS_UNPARSED_ARGUMENTS}
                    SOURCE_DIR          "${DL_ARGS_SOURCE_DIR}"
                    BINARY_DIR          "${DL_ARGS_BINARY_DIR}"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/ConfigSafeGuards.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#
# Adapted from: https://github.com/bast/cmake-example/tree/master/cmake
#==================================================
#

# guard against in-source builds
if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.")
endif()

# guard against bad build-type strings
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

string(TOLOWER "${CMAKE_BUILD_TYPE}" cmake_build_type_tolower)
string(TOUPPER "${CMAKE_BUILD_TYPE}" cmake_build_type_toupper)
if(    NOT cmake_build_type_tolower STREQUAL "debug"
   AND NOT cmake_build_type_tolower STREQUAL "release"
   AND NOT cmake_build_type_tolower STREQUAL "profile"
   AND NOT cmake_build_type_tolower STREQUAL "relwithdebinfo")
      message(FATAL_ERROR "Unknown build type \"${CMAKE_BUILD_TYPE}\". Allowed values are Debug, Release, Profile, RelWithDebInfo (case-insensitive).")
endif()

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/FindGit.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#
# Adapted from: https://github.com/bast/cmake-example/tree/master/cmake
#==================================================
#
find_program(
    GIT_EXECUTABLE
    NAMES git
    DOC "git command line client"
    )
mark_as_advanced(GIT_EXECUTABLE)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Git DEFAULT_MSG GIT_EXECUTABLE)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/ConfigGitRevision.cmake"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#
# Adapted from: https://github.com/bast/cmake-example/tree/master/cmake
#==================================================
#
find_package(Git)
if(GIT_FOUND)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-list --max-count=1 HEAD
        OUTPUT_VARIABLE OUR_PROJECT_NAME_GIT_REVISION
        ERROR_QUIET
        )
    if(NOT ${OUR_PROJECT_NAME_GIT_REVISION} STREQUAL "")
        string(STRIP ${OUR_PROJECT_NAME_GIT_REVISION} OUR_PROJECT_NAME_GIT_REVISION)
    endif()
    message(STATUS "Current git revision is ${OUR_PROJECT_NAME_GIT_REVISION}")
else()
    set(OUR_PROJECT_NAME_GIT_REVISION "unknown")
endif()

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi

#**************************************************

current_file="${project_path}/${project_name}/cmake/config.hpp.in"
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir="$(dirname "${current_file}")"

mkdir -p "${current_file_dir}"
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

//==================================================
// Automatically generated, but not overwritten
//==================================================
// CAVEAT: config.hpp.in is never overwritten, but config.hpp is!
//

#pragma once

/** @file 
 *  @brief OUR_PROJECT_NAME configuration file
 *  
 *  @attention automatically generated from @b config.hpp.in, do not modify!
 */

#define OUR_PROJECT_NAME_VERSION_MAJOR @OUR_PROJECT_NAME_VERSION_MAJOR@  
#define OUR_PROJECT_NAME_VERSION_MINOR @OUR_PROJECT_NAME_VERSION_MINOR@
#define OUR_PROJECT_NAME_VERSION_PATCH @OUR_PROJECT_NAME_VERSION_PATCH@
#define OUR_PROJECT_NAME_GIT_REVISION "@OUR_PROJECT_NAME_GIT_REVISION@"

#define OUR_PROJECT_NAME_SYSTEM_NAME @CMAKE_SYSTEM_NAME@
#define OUR_PROJECT_NAME_HOST_SYSTEM_PROCESSOR @CMAKE_HOST_SYSTEM_PROCESSOR@

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi
