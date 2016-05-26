# Detect if super project or not
#
if(${CMAKE_PROJECT_NAME} STREQUAL ${PROJECT_NAME}) 
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Stand-alone project
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  # from https://github.com/Crascit/DownloadProject/blob/master/CMakeLists.txt
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
    SOURCE_DIR          ${CMAKE_BINARY_DIR}/gtest
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
