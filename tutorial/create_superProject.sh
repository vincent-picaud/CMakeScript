
../createProject.sh superProject/project_A
../createProject.sh superProject/project_B
../createProject.sh superProject/project_C

project_path=./
project_name=superProject

current_file=${project_path}/${project_name}/CMakeLists.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

cmake_minimum_required(VERSION 3.0)
project(superProject)

# Your 3 sub-projects
#
add_subdirectory(project_A)
add_subdirectory(project_B)
add_subdirectory(project_C)

# Target: test
#--------------------------------------------------
# (if you want to use a CDash board, you must define a CTestConfig.cmake file,
#  in the superProject root directory)
include(CTest)

# Target: doc
#--------------------------------------------------
# Define a global "doc" target:
# This target build sequentially project_A_doc project_B_doc and project_C_doc
#
add_custom_target(doc DEPENDS project_A_doc project_B_doc project_C_doc)

//GO.SYSIN DD PRIVATE_DD_TAG
fi

#==================================================

current_file=${project_path}/${project_name}/project_C/cmake/project_CDependencies.cmake
#
# CAVEAT: here, for the example, we must overwrite!
#
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

# C depends on A
#
if(NOT TARGET project_A)
  find_package(project_A CONFIG REQUIRED)
  if(NOT ${project_A_FOUND}) 
     message(FATAL_ERROR "Did not found project_A module!")
  endif()
endif()
target_link_libraries(project_C project_A)

# C depends on B
#
if(NOT TARGET project_B)
  find_package(project_B CONFIG REQUIRED)
  if(NOT ${project_B_FOUND}) 
     message(FATAL_ERROR "Did not found project_B module!")
  endif()
endif()
target_link_libraries(project_C project_B)

//GO.SYSIN DD PRIVATE_DD_TAG
