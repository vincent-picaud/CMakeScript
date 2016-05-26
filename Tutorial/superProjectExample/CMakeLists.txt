cmake_minimum_required(VERSION 3.0)
project(Modular_Kiss)

set(CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH}
  ${PROJECT_SOURCE_DIR}/cmake
  )

include(CTest)
enable_testing()

include(ConfigGTest)
add_subdirectory(Kiss_Common)
add_subdirectory(Kiss_AD)
add_subdirectory(Kiss_LinAlg)


