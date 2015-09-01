
#**************************************************
# A script to generate C++ project skeletons
# Fri Jul 24 2015
# V. Picaud,
# https://github.com/vincent-picaud/CMakeScript
#**************************************************

if [ "$#" -ne 1 ]; then
    echo -e "\\n\\nUsage is:\\n" $0 " project_name\\n"
    exit -1
fi

echo -e "Create C++ empty project skeleton: $1"

#**************************************************
# Generate an "empty" skeleton C++ project
# -> populate it with your C++ files
# -> call createProject.sh to generate the CMakefiles, etc.
#**************************************************

project_name="$(basename "$1" | tr -st ' ' '_' )"
project_path="$(dirname "$1")"

mkdir -p ${project_path}/${project_name}/${project_name}
mkdir -p ${project_path}/${project_name}/bin
mkdir -p ${project_path}/${project_name}/examples
mkdir -p ${project_path}/${project_name}/test
mkdir -p ${project_path}/${project_name}/doc/doxygen/
mkdir -p ${project_path}/${project_name}/doc/figures
mkdir -p ${project_path}/${project_name}/cmake
