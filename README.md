<div id="content">

<div id="table-of-contents">

Table of Contents
-----------------

<div id="text-table-of-contents">

-   [1. Introduction](#sec-1)
    -   [1.1. Motivations](#sec-1-1)
    -   [1.2. Emacs, org-mode…](#sec-1-2)
    -   [1.3. Getting started](#sec-1-3)
        -   [1.3.1. A simple **myProject**](#sec-1-3-1)
        -   [1.3.2. A simple **super-project**](#sec-1-3-2)
    -   [1.4. <span class="todo TODO">TODO</span>](#sec-1-4)
-   [2. Recipes for the **createProject.sh** script](#sec-2)
    -   [2.1. The **cpp files**](#sec-2-1)
        -   [2.1.1. **Library** cpp files](#sec-2-1-1)
        -   [2.1.2. **Executable** C++ file](#sec-2-1-2)
        -   [2.1.3. **Example** C++ file](#sec-2-1-3)
    -   [2.2. **Doxygen** configuration file](#sec-2-2)
        -   [2.2.1. Bibliography](#sec-2-2-1)
        -   [2.2.2. Figures](#sec-2-2-2)
    -   [2.3. The **CMakeLists.txt** files](#sec-2-3)
        -   [2.3.1. **Main** CMakeLists.txt](#sec-2-3-1)
        -   [2.3.2. **Library** CMakeLists.txt](#sec-2-3-2)
        -   [2.3.3. **Binary** CMakeLists.txt](#sec-2-3-3)
        -   [2.3.4. **Examples** CMakeLists.txt](#sec-2-3-4)
        -   [2.3.5. **GTest/CTest** CMakeLists.txt](#sec-2-3-5)
        -   [2.3.6. The **cmake/** directory](#sec-2-3-6)
-   [3. Catalog of **shell scripts**](#sec-3)
    -   [3.1. The **tutorial** scripts](#sec-3-1)
        -   [3.1.1. A simple **project**](#sec-3-1-1)
        -   [3.1.2. A simple **super-project**](#sec-3-1-2)
    -   [3.2. The **createProject.sh** script](#sec-3-2)
        -   [3.2.1. The **createEmptyProject.sh** script](#sec-3-2-1)

</div>

</div>

<div id="outline-container-sec-1" class="outline-2">

<span class="section-number-2">1</span> Introduction {#sec-1}
----------------------------------------------------

<div id="text-1" class="outline-text-2">

</div>

<div id="outline-container-sec-1-1" class="outline-3">

### <span class="section-number-3">1.1</span> Motivations {#sec-1-1}

<div id="text-1-1" class="outline-text-3">

**CMake** is a great tool, however despite all its advantages it is
sometimes boring to create a new build solution for each new C++
project. The aim of these **shell scripts** is to provide a working (at
least I hope so) project skeleton in one command line:

``` {.example}
sh createProject.sh myProject
```

I developed these **shell scripts** for my personal usages under
**Linux**. By consequence they are currently not tested for **Windows**
or other **OS**. Feel free to modify them, feed backs or pull requests
are welcome.

To create these **shell scripts** I picked up some code snippets from
various sources. When this happened I put the corresponding **link** to
the original source.

My main sources of information were:

-   [official cmake site](http://www.cmake.org/documentation/)
-   [bast/cmake-example](https://github.com/bast/cmake-example) and his
    homepage with [a lot of interesting talks concerning cmake,
    git…](http://bast.fr/talks/)
-   various **stackoverflow** questions and/or **github** projects:
    [here](http://stackoverflow.com/questions/20746936/cmake-of-what-use-is-find-package-if-you-need-to-specify-cmake-module-path-an),
    [here](https://github.com/forexample/package-example) or
    [here](https://github.com/scumm/foobar).

</div>

</div>

<div id="outline-container-sec-1-2" class="outline-3">

### <span class="section-number-3">1.2</span> Emacs, org-mode… {#sec-1-2}

<div id="text-1-2" class="outline-text-3">

All theses **shell scripts** are **automatically** generated using
[emacs + org-mode](http://orgmode.org/) from an unique **cmake.org**
source file. For the hasty users or for those who do not have **emacs**
and **org-mode** properly installed I also provide the generated scripts
for a direct usage. However any modification must be done by editing the
**cmake.org** source file first and then by re-generating the scripts
with the [C-c C-v
t](http://orgmode.org/manual/Extracting-source-code.html) command.

</div>

</div>

<div id="outline-container-sec-1-3" class="outline-3">

### <span class="section-number-3">1.3</span> Getting started {#sec-1-3}

<div id="text-1-3" class="outline-text-3">

</div>

<div id="outline-container-sec-1-3-1" class="outline-4">

#### <span class="section-number-4">1.3.1</span> A simple **myProject** {#sec-1-3-1}

<div id="text-1-3-1" class="outline-text-4">

To create your first project, go into the **tutorial/** directory and
run

<div class="org-src-container">

``` {#Create_MyProject .src .src-sh}
../createProject.sh myProject
```

</div>

This will create the following **project skeleton**. By default the
script **never** overwrite created files. Thats means that you can
safely update your build system by reusing the **createProject.sh**
script. Some files are protected against **writing**, this is only a
hint to notify that for a basic usage your generaly do not have to
modify them. However, if you need more tuning you can safely modify
them, your modifications will **not** be erased by the script.

<div class="org-src-container">

``` {.src .src-txt}
Project Skeleton                Read only right   Comments    
                                         |
myProject/                               |
├── cmake........................................ Contains the cmake stuff
│   ├── ConfigGitRevision.cmake..........R....... Retrieves git hash
│   ├── config.hpp.in....................R....... Project configuration macros, configured by cmake script
│   ├── ConfigSafeGuards.cmake...........R....... Block in-source-build
│   ├── ConfigTesting.cmake..............R....... Creates BUILDNAME and enable CTest
│   ├── FindGit.cmake....................R....... Find git
│   ├── myProjectConfig.cmake.in................. Contains your default project configuration, no modification needed for a basic usage
│   └── myProjectDependencies.cmake.............. Contains your project dependencies, you can edit it (not erased by the script)
├── doc
│   ├── doxygen.................................. Doxygen stuff, 
│   │   ├── CMakeLists.txt...............R....... Creates documentation targets
│   │   ├── doxyfile.in.......................... Your doxygen configuration file, modify me!
│   ├── figures
│   │   └── readme.txt
│   └── myProject_bibliography.bib............... A bibTeX bib file, can be used with Doxygen, modify me!
├── myProject
│   ├── CMakeLists.txt...................R.......
│   ├── toRemove_git_hash.cpp.................... Just there to have something to compile for myProject library, remove me! Installed in include/ 
│   └── toRemove_git_hash.hpp.................... Just there to have something to compile for myProject library, remove me! Installed in include/myProject 
├── test
│   ├── CMakeLists.txt...................R.......
│   └── toRemove_check_git_hash.cpp.............. CTest/CDash & gtest unit test example, remove me and add more! :-)
├── bin.......................................... A directory that contains binary files, they are installed in bin/                           
│   ├── CMakeLists.txt...................R.......
│   └── toRemove_myProject_git_hash.cpp.......... Just there to have something to compile, remove me! (take care of bin file name collisions in bin/ !!!)
├── examples..................................... A directory that contains example files, they are NOT installed
│   ├── CMakeLists.txt...................R.......
│   └── toRemove_example.cpp..................... Just there to have something to compile, remove me!
├── CMakeLists.txt.......................R.......
└── CTestConfig.cmake....................R....... CTest/CDash configuration file
```

</div>

To test the generated project you can use the **check\_myProject.sh**
script

<div class="org-src-container">

``` {.src .src-sh}
./check_myProject.sh
```

</div>

This script performs the following tasks

<div class="org-src-container">

``` {#Check_MyProject .src .src-sh}
# Create build dir
#
cd myProject
mkdir build
cd build
cmake ..

# Check build
#
make

# Check documentation (generated by Doxygen)
# (open myProject/build/doc/doxygen/index.html with your web browser)
#
make doc

# Check (local) install
#
make DESTDIR=local_install install

# check test 
#
make test

# ctest (+ cdash board)
# 
ctest -D Experimental
```

</div>

The approach is to perform an **out-of-source-build**.

The reason is twofold:

-   this allows the creation of **super-project** containing several
    **sub-projects**
-   this is really convenient if you use **git**, as the following
    **.gitignore** file

<div class="org-src-container">

``` {.src .src-txt}
$ cat .gitignore
build*/
```

</div>

will filter out all the built files (**git status** is not polluted by
generated files)

Note that any tentative of **in-source-build** is detected generate an
error [2.3.6.5](#in-source-build).

One of the main advantage of the proposed script is that it
automatically **exports** the project. If you want to use **myProject**
in another cmake-built project, simply add

<div class="org-src-container">

``` {.src .src-txt}
if(NOT TARGET myProject)
find_package(myProject CONFIG REQUIRED)

if(NOT ${myProject_FOUND}) 
   message(FATAL_ERROR "Did not found myProject module!")
endif(NOT ${myProject_FOUND})
endif()

target_link_libraries(yourProject myProject)
```

</div>

in your project dependencies. You can take a look at
[[[2.3.6.2](#project-dependencies)]] for further details

This Export/Import feature is illustrated in the next paragraph

</div>

</div>

<div id="outline-container-sec-1-3-2" class="outline-4">

#### <span class="section-number-4">1.3.2</span> A simple **super-project** {#sec-1-3-2}

<div id="text-1-3-2" class="outline-text-4">

The **createProject.sh** script has been developed with the aim to
easily create a **super-project**.

A **super-project** is a collection of **sub-projects** generated by the
same **createProject.sh** script.

All dependencies are managed, that means if you have two projects,
**project\_A** and **project\_B** any modification of **project\_A**
leads to a re-build of **project\_B**. In the same way any dependence of
**project\_A** is exported to **project\_B**.

Moreover the configuration offers **two ways of working**:

-   you can build, modify… your **super-project** with its own
    **CMakeLists.txt** file
-   you can **locally** build, modify… any of its **sub-project**

To see how it works, go into the **tutorial/** directory and create
three sub-projects, **project\_A**, **project\_B** and **project\_C**:

<div class="org-src-container">

``` {#Create_SuperProject_subProject .src .src-sh}
../createProject.sh superProject/project_A
../createProject.sh superProject/project_B
../createProject.sh superProject/project_C
```

</div>

Then you have to create your super-project
**superProject/CMakeLists.txt** file, here is the code:

<div class="org-src-container">

``` {#Create_SuperProject_CMakeLists .src .src-txt}
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
```

</div>

For dependencies you have to overwrite some
**ProjectDependencies.cmake** files. Lets say that **project\_C**
depends on **project\_A** and **project\_B**. In this simple case you
only have to redefine **project\_C/cmake/ProjectDependencies.cmake**
with:

<div class="org-src-container">

``` {#Create_SuperProject_C_AB .src .src-txt}
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
```

</div>

That is all!

Now the **super-project** can be tested using the
**check\_superProject.sh** script.

<div class="org-src-container">

``` {.src .src-sh}
./check_superProject.sh
```

</div>

This script perform exactly the same tasks that the **myProject** one:

<div class="org-src-container">

``` {#Check_SuperProject .src .src-sh}
# Create build dir
#
cd superProject
mkdir build
cd build
cmake ..

# Check build
#
make

# check documentation (generated by Doxygen)
#
make doc

# check (local) install
#
make DESTDIR=local_install install

# check test 
#
make test

# ctest (+ cdash board)
# -> create a cdash board before
# ctest -D Experimental
```

</div>

</div>

</div>

</div>

<div id="outline-container-sec-1-4" class="outline-3">

### <span class="section-number-3">1.4</span> <span class="todo TODO">TODO</span> {#sec-1-4}

<div id="text-1-4" class="outline-text-3">

-   Include more examples
-   Test for other configurations: cmake version, host machine…
-   Configure for SIMD, OpenMP… however the result is maybe too oriented
    toward numerical applications

</div>

</div>

</div>

<div id="outline-container-sec-2" class="outline-2">

<span class="section-number-2">2</span> Recipes for the **createProject.sh** script {#sec-2}
-----------------------------------------------------------------------------------

<div id="text-2" class="outline-text-2">

</div>

<div id="outline-container-sec-2-1" class="outline-3">

### <span class="section-number-3">2.1</span> The **cpp files** {#sec-2-1}

<div id="text-2-1" class="outline-text-3">

We begin by creating some C++ files used to check that everything is
working as expected.

</div>

<div id="outline-container-sec-2-1-1" class="outline-4">

#### <span class="section-number-4">2.1.1</span> **Library** cpp files {#sec-2-1-1}

<div id="text-2-1-1" class="outline-text-4">

These files are needed to create the **OUR\_PROJECT\_NAME** library

<div class="org-src-container">

``` {#toRemove_git_hash.hpp .src .src-C}
/** @file
 *  @brief A file from the OUR_PROJECT_NAME library
 */
#include <string>

namespace OUR_PROJECT_NAME {

/** @brief A function that returns the git hash
 *
 *  Its role is to check link with @ref toRemove_OUR_PROJECT_NAME_git_hash.cpp
 */
std::string git_hash();

} /* OUR_PROJECT_NAME */
```

</div>

<div class="org-src-container">

``` {#toRemove_git_hash.cpp .src .src-C}
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>
#include <OUR_PROJECT_NAME/config.hpp>

namespace OUR_PROJECT_NAME {

std::string git_hash()
{
    return std::string(OUR_PROJECT_NAME_GIT_REVISION);
}

} /* OUR_PROJECT_NAME */
```

</div>

</div>

</div>

<div id="outline-container-sec-2-1-2" class="outline-4">

#### <span class="section-number-4">2.1.2</span> **Executable** C++ file {#sec-2-1-2}

<div id="text-2-1-2" class="outline-text-4">

This file is required to show how executables are build and
**installed** in the **bin** directory

<div class="org-src-container">

``` {#toRemove_OUR_PROJECT_NAME_git_hash.cpp .src .src-C}
/** @file
 *  @brief A file from the OUR_PROJECT_NAME binary directory
 */
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>
#include <iostream>

using namespace OUR_PROJECT_NAME;

/** @brief Returns the git hash
 *
 *  Usage:
 *  @code
 *  ./toRemove_OUR_PROJECT_NAME_git_hash
 *  @endcode
 *
 *  @note this executable is installed in @b bin/
 */
int main()
{
    std::cout << "\nCurrent git hash is " << git_hash();
}
```

</div>

</div>

</div>

<div id="outline-container-sec-2-1-3" class="outline-4">

#### <span class="section-number-4">2.1.3</span> **Example** C++ file {#sec-2-1-3}

<div id="text-2-1-3" class="outline-text-4">

This file is required to show how examples are build. They are **not**
installed and stay in the build-tree.

<div class="org-src-container">

``` {#toRemove_example.cpp .src .src-C}
/** @file
 *  @brief A file from the OUR_PROJECT_NAME examples directory
 *
 *  @include toRemove_example.cpp
 *
 *  Also note that you can:
 *    - include figures: @image html figures/one_figure.png
 *
 *    - use bibliographic reference @cite Heesch2008 
 * 
 */
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>
#include <iostream>

using namespace OUR_PROJECT_NAME;

/** @brief Returns the git hash
 *
 *  Usage:
 *  @code
 *  ./toRemove_git_hash
 *  @endcode
 *
 *  @note this executable is @b not installed in @b bin/
 */
int main()
{
   std::cout << "\nCurrent git hash is " << git_hash();
}
```

</div>

</div>

</div>

</div>

<div id="outline-container-sec-2-2" class="outline-3">

### <span class="section-number-3">2.2</span> **Doxygen** configuration file {#sec-2-2}

<div id="text-2-2" class="outline-text-3">

Next we define a **doxyfile.in** configuration file stored in the
**doc/doxygen/** directory. This is only an example, you can use your
own configuration, you only have to take care of the directory paths.

<div class="org-src-container">

``` {#doxyfile.in .src .src-txt}
PROJECT_NAME           = OUR_PROJECT_NAME
PROJECT_NUMBER         = @OUR_PROJECT_NAME_VERSION@

HIDE_UNDOC_MEMBERS     = YES
HIDE_UNDOC_CLASSES     = YES
HIDE_FRIEND_COMPOUNDS  = YES

REPEAT_BRIEF           = NO
ALWAYS_DETAILED_SEC    = NO

CITE_BIB_FILES         = @PROJECT_SOURCE_DIR@/doc/OUR_PROJECT_NAME_bibliography.bib

WARN_LOGFILE           = doxygenError.txt

INPUT                  = @PROJECT_SOURCE_DIR@/OUR_PROJECT_NAME \
                         @PROJECT_SOURCE_DIR@/examples \
                         @PROJECT_SOURCE_DIR@/bin \
                         @PROJECT_SOURCE_DIR@/test

FILE_PATTERNS          = *.hpp *.cpp
RECURSIVE              = YES

EXCLUDE_PATTERNS       =  */moc_/* */_automoc/*
EXAMPLE_PATH           = @PROJECT_SOURCE_DIR@/examples 
EXAMPLE_PATTERNS       = *.cpp
EXAMPLE_RECURSIVE      = YES

IMAGE_PATH             = @PROJECT_SOURCE_DIR@/doc/figures/

EXTRA_PACKAGES         = mathtools \
                         amsfonts \
                         stmaryrd
             
PREDEFINED             = DOXYGEN_DOC
SKIP_FUNCTION_MACROS   = NO

COLLABORATION_GRAPH    = NO
INCLUDE_GRAPH          = NO
INCLUDED_BY_GRAPH      = NO
GRAPHICAL_HIERARCHY    = NO
DIRECTORY_GRAPH        = NO
```

</div>

We then have to create the corresponding **CMakeLists.txt**

<div class="org-src-container">

``` {#DoxygenCMakeList .src .src-txt}
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
```

</div>

</div>

<div id="outline-container-sec-2-2-1" class="outline-4">

#### <span class="section-number-4">2.2.1</span> Bibliography {#sec-2-2-1}

<div id="text-2-2-1" class="outline-text-4">

Doxygen supports **bibTeX** files. To use this feature you only have to
create a **bibliography.bib** file in the **doc/** directory.

<div class="org-src-container">

``` {#bibliography.bib .src .src-txt}
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
```

</div>

You can include a citation with:

<div class="org-src-container">

``` {.src .src-txt}
/*
 * @cite Heesch2008 
 */
```

</div>

</div>

</div>

<div id="outline-container-sec-2-2-2" class="outline-4">

#### <span class="section-number-4">2.2.2</span> Figures {#sec-2-2-2}

<div id="text-2-2-2" class="outline-text-4">

We also have defined the **doc/figures** subdirectory to store figures.
These figures can be included in the doxygen doc:

<div class="org-src-container">

``` {.src .src-txt}
/*
 * @image html figures/one_figure.png
 */
```

</div>

</div>

</div>

</div>

<div id="outline-container-sec-2-3" class="outline-3">

### <span class="section-number-3">2.3</span> The **CMakeLists.txt** files {#sec-2-3}

<div id="text-2-3" class="outline-text-3">

</div>

<div id="outline-container-sec-2-3-1" class="outline-4">

#### <span class="section-number-4">2.3.1</span> **Main** CMakeLists.txt {#sec-2-3-1}

<div id="text-2-3-1" class="outline-text-4">

The main **CMakeFiles.txt** is defined below. This is an adaptation of
[](https://github.com/bast/cmake-example/blob/master/CMakeLists.txt)<https://github.com/bast/cmake-example/blob/master/CMakeLists.txt>.

<div class="org-src-container">

``` {#MainCMakeList .src .src-txt}
#**************************************************
# A script to generate C++ project skeletons
# Fri Jul 24 2015
# V. Picaud,
# https://github.com/vincent-picaud/CMakeScript
#**************************************************

#==================================================
# Automatically generated, but never overwritten
#
# Adapted from: https://github.com/bast/cmake-example/blob/master/CMakeLists.txt
#==================================================
#
cmake_minimum_required(VERSION 3.0)
project(OUR_PROJECT_NAME)
 
# enable fortran, c, and c++ language
#
enable_language(Fortran C CXX)

# OUR_PROJECT_NAME version
#
set(OUR_PROJECT_NAME_VERSION_MAJOR 0)
set(OUR_PROJECT_NAME_VERSION_MINOR 1)
set(OUR_PROJECT_NAME_VERSION_PATCH 0)
set(OUR_PROJECT_NAME_VERSION ${OUR_PROJECT_NAME_VERSION_MAJOR}.${OUR_PROJECT_NAME_VERSION_MINOR}.${OUR_PROJECT_NAME_VERSION_PATCH})

# Location of additional cmake modules
#
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${PROJECT_SOURCE_DIR}/cmake
    )

# Guard against in-source builds and bad build-type strings
#
include(ConfigSafeGuards)

# CTest and CDash stuff
#
include(ConfigTesting)

# Example how to set c++ compiler flags for GNU
#
if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wno-unknown-pragmas -Wno-sign-compare -Woverloaded-virtual -Wwrite-strings -Wno-unused")
    set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g3")
    set(CMAKE_CXX_FLAGS_RELEASE "-O2 -DNDEBUG")
    set(CMAKE_CXX_FLAGS_COVERAGE "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage")
endif()


#--------------------------------------------------
# Header files
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

# Location of header files
#
# CAVEAT: a priori must stay synchronized with OUR_PROJECT_NAME/OUR_PROJECT_NAME/CMakeLists.txt 
#         target_include_directories(...)
#
include_directories(
    # search file in source directories
    ${PROJECT_SOURCE_DIR}/
    # otherwise try in the binary directory 
    # (to include the generated config.hpp for instance)
    ${PROJECT_BINARY_DIR}/
)

#--------------------------------------------------
# Explore sub-directories
#--------------------------------------------------
#
# Our OUR_PROJECT_NAME testing framework (gtest)
#
add_subdirectory(${PROJECT_SOURCE_DIR}/test/)

# Our OUR_PROJECT_NAME library build
#
add_subdirectory(${PROJECT_SOURCE_DIR}/OUR_PROJECT_NAME/)

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
```

</div>

</div>

</div>

<div id="outline-container-sec-2-3-2" class="outline-4">

#### <span class="section-number-4">2.3.2</span> **Library** CMakeLists.txt {#sec-2-3-2}

<div id="text-2-3-2" class="outline-text-4">

<div class="org-src-container">

``` {#LibraryCMakeList .src .src-txt}
#==================================================
# Build OUR_PROJECT_NAME library
# Automatically generated, but not overwritten
#==================================================
#

#--------------------------------------------------
# Collect files and define target for the library
#--------------------------------------------------

# Collect files
# 
file(GLOB_RECURSE OUR_PROJECT_NAME_LIB_SOURCE_CPP *.cpp)
file(GLOB_RECURSE OUR_PROJECT_NAME_LIB_SOURCE_HPP *.hpp)

add_library(OUR_PROJECT_NAME SHARED 
            ${OUR_PROJECT_NAME_LIB_SOURCE_CPP} 
            ${OUR_PROJECT_NAME_LIB_SOURCE_HPP})

# Target properties
#
set_target_properties(OUR_PROJECT_NAME 
                      PROPERTIES PUBLIC_HEADER "${OUR_PROJECT_NAME_LIB_SOURCE_HPP}")


# Here we define the include paths that will be used by our clients.
# see: http://www.cmake.org/cmake/help/v3.0/command/target_include_directories.html
# 
# CAVEAT: a priori must stay synchronized with OUR_PROJECT_NAME/CMakeLists.txt include_directory(...)
#
target_include_directories(OUR_PROJECT_NAME PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/>
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/>
    $<INSTALL_INTERFACE:include/>
)

# Library version
# http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html
#
set_property(TARGET OUR_PROJECT_NAME PROPERTY VERSION ${OUR_PROJECT_NAME_VERSION})
set_property(TARGET OUR_PROJECT_NAME PROPERTY SOVERSION ${OUR_PROJECT_NAME_MAJOR_VERSION})
set_property(TARGET OUR_PROJECT_NAME PROPERTY INTERFACE_OUR_PROJECT_NAME_MAJOR_VERSION ${OUR_PROJECT_NAME_MAJOR_VERSION})
set_property(TARGET OUR_PROJECT_NAME APPEND PROPERTY COMPATIBLE_INTERFACE_STRING "${OUR_PROJECT_NAME_MAJOR_VERSION}")

#--------------------------------------------------
# Include dependencies
#--------------------------------------------------
# You can add/remove what you need in the cmake/OUR_PROJECT_NAMEDependencies.cmake file
#
include(${PROJECT_SOURCE_DIR}/cmake/OUR_PROJECT_NAMEDependencies.cmake)

#--------------------------------------
# Installation
#--------------------------------------

# Install library & header file
install(TARGETS OUR_PROJECT_NAME EXPORT OUR_PROJECT_NAMETargets
  LIBRARY DESTINATION lib/OUR_PROJECT_NAME
  ARCHIVE DESTINATION lib/OUR_PROJECT_NAME
  RUNTIME DESTINATION bin/OUR_PROJECT_NAME
  PUBLIC_HEADER DESTINATION include/OUR_PROJECT_NAME
)

# Do not forget config.hpp
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/config.hpp"
  DESTINATION
    include/OUR_PROJECT_NAME
)
```

</div>

</div>

</div>

<div id="outline-container-sec-2-3-3" class="outline-4">

#### <span class="section-number-4">2.3.3</span> **Binary** CMakeLists.txt {#sec-2-3-3}

<div id="text-2-3-3" class="outline-text-4">

<div class="org-src-container">

``` {#BinCMakeLists.txt .src .src-txt}
#==================================================
# Build OUR_PROJECT_NAME executables
# Automatically generated, but not overwritten
#==================================================
#

# Collect files
# --------------------------------------------------
#
file(GLOB_RECURSE ALL_SOURCES_CPP *.cpp)

# For each executables
# --------------------------------------------------
#
foreach(ONE_SOURCE_CPP ${ALL_SOURCES_CPP})

# Build it!
#
get_filename_component(ONE_SOURCE_EXEC ${ONE_SOURCE_CPP} NAME_WE)
# Avoid name collision 
# (trick found at:http://cmake.3232098.n2.nabble.com/What-is-the-preferred-way-to-avoid-quot-same-name-already-exists-quot-error-td7585687.html)
add_executable(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} ${ONE_SOURCE_CPP})
set_target_properties(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} PROPERTIES OUTPUT_NAME ${ONE_SOURCE_EXEC}) 
target_link_libraries(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} OUR_PROJECT_NAME)

# Install (& Export) for external usage
#
install(TARGETS OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} 
        EXPORT OUR_PROJECT_NAMETargets
        RUNTIME DESTINATION bin)
endforeach()
```

</div>

</div>

</div>

<div id="outline-container-sec-2-3-4" class="outline-4">

#### <span class="section-number-4">2.3.4</span> **Examples** CMakeLists.txt {#sec-2-3-4}

<div id="text-2-3-4" class="outline-text-4">

<div class="org-src-container">

``` {#ExampleCMakeList .src .src-txt}
#==================================================
# OUR_PROJECT_NAME executables
# Automatically generated, but not overwritten
#==================================================
#

# Collect files
# --------------------------------------------------
#
file(GLOB_RECURSE ALL_SOURCES_CPP *.cpp)

# For each examples
# --------------------------------------------------
#
foreach(ONE_SOURCE_CPP ${ALL_SOURCES_CPP})

# Build it!
#
get_filename_component(ONE_SOURCE_EXEC ${ONE_SOURCE_CPP} NAME_WE)
# Avoid name collision 
# (trick found at:http://cmake.3232098.n2.nabble.com/What-is-the-preferred-way-to-avoid-quot-same-name-already-exists-quot-error-td7585687.html)
add_executable(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} ${ONE_SOURCE_CPP})
set_target_properties(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} PROPERTIES OUTPUT_NAME ${ONE_SOURCE_EXEC}) 
target_link_libraries(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} OUR_PROJECT_NAME)

# CAVEAT: no installation, examples are not exported from the build-tree
#
endforeach()
```

</div>

</div>

</div>

<div id="outline-container-sec-2-3-5" class="outline-4">

#### <span class="section-number-4">2.3.5</span> **GTest/CTest** CMakeLists.txt {#sec-2-3-5}

<div id="text-2-3-5" class="outline-text-4">

<div class="org-src-container">

``` {#GTestCMakeList .src .src-txt}
#==================================================
# OUR_PROJECT_NAME unit tests
# Automatically generated, but not overwritten
#==================================================
#

# find GTest
#--------------------------------------------------

find_package(Threads REQUIRED)
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

# Generate tests and associated targets
#--------------------------------------------------
file(GLOB_RECURSE ALL_TESTS_CPP *.cpp)

foreach(ONE_TEST_CPP ${ALL_TESTS_CPP})
   # Build it!
   #
   get_filename_component(ONE_TEST_EXEC ${ONE_TEST_CPP} NAME_WE)
   # Avoid name collision 
   # (trick found at:http://cmake.3232098.n2.nabble.com/What-is-the-preferred-way-to-avoid-quot-same-name-already-exists-quot-error-td7585687.html)
   add_executable(OUR_PROJECT_NAME_${ONE_TEST_EXEC} ${ONE_TEST_CPP})
   set_target_properties(OUR_PROJECT_NAME_${ONE_TEST_EXEC} PROPERTIES OUTPUT_NAME ${ONE_TEST_EXEC}) 
   target_link_libraries(OUR_PROJECT_NAME_${ONE_TEST_EXEC} 
                         OUR_PROJECT_NAME
                         ${GTEST_BOTH_LIBRARIES}
                         ${CMAKE_THREAD_LIBS_INIT})
   # CTest
   add_test(OUR_PROJECT_NAME_${ONE_TEST_EXEC} ${ONE_TEST_EXEC})
endforeach()
```

</div>

Define a trivial test used to check that everything is okay:

<div class="org-src-container">

``` {#toRemove_check_git_hash.cpp .src .src-txt}
#include "gtest/gtest.h"
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>

using namespace OUR_PROJECT_NAME;

TEST(Demo,Trivial) {
   EXPECT_TRUE(true);
}
```

</div>

</div>

</div>

<div id="outline-container-sec-2-3-6" class="outline-4">

#### <span class="section-number-4">2.3.6</span> The **cmake/** directory {#sec-2-3-6}

<div id="text-2-3-6" class="outline-text-4">

Again a major source of inspiration was
<https://github.com/bast/cmake-example/blob/master/CMakeLists.txt>.

</div>

1.  <span id="sec-2-3-6-1"></span>The **CTestConfig.cmake** file\
    <div id="text-2-3-6-1" class="outline-text-5">

    This file must be in the project **root** directory.

    <div class="org-src-container">

    ``` {#CTestConfig.cmake .src .src-txt}
    #==================================================
    # Automatically generated, but not overwritten
    #==================================================

    set(CTEST_PROJECT_NAME       "OUR_PROJECT_NAME")
    set(CTEST_NIGHTLY_START_TIME "00:00:00 CEST")
    set(CTEST_DROP_METHOD        "http")
    set(CTEST_DROP_SITE          "my.cdash.org")
    set(CTEST_DROP_LOCATION      "/submit.php?project=OUR_PROJECT_NAME")
    set(CTEST_DROP_SITE_CDASH    TRUE)
    set(CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS 200)
    ```

    </div>

    </div>

2.  <span id="sec-2-3-6-2"></span><span
    id="project-dependencies"></span> The **ProjectDependencies.cmake**
    file\
    <div id="text-2-3-6-2" class="outline-text-5">

    The **OUR\_PROJECT\_NAMEDependencies.cmake** file contains your
    project dependencies. This is an important file and you have to
    modify it for your own needs.

    <div class="org-src-container">

    ``` {#ProjectDependencies.cmake .src .src-txt}
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
    # For a "Super-Project" containing projectUpstream and OUR_PROJECT_NAME,
    # if OUR_PROJECT_NAME depends on projectUpstream, simply uncomment me
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # if(NOT TARGET projectUpstream)
    # find_package(projectUpstream CONFIG REQUIRED)
    # if(NOT ${projectUpstream_FOUND}) 
    #    message(FATAL_ERROR "Did not found projectUpstream module!")
    # endif()
    # endif()
    # target_link_libraries(OUR_PROJECT_NAME projectUpstream)
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Note: the role of the if(NOT TARGET projectUpstream) guard is only relevant in case
    #       of super-project build where "projectUpstream" is included by add_subdirectory
    #       from a master CMakeLists.txt file.
    #       In that case the file projectUpstreamTargets.cmake is not yet generated and
    #       find_package(projectUpstream CONFIG REQUIRED) would generate a "file not found" 
    #       error. However the target projectUpstream is already available.

    # BLAS
    #--------------------------------------------------
    # If you project depends on BLAS, uncomment me
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #enable_language(Fortran)
    #find_package(BLAS REQUIRED)
    #include_directories(${BLAS_INCLUDE_DIRS})
    #target_include_directories(OUR_PROJECT_NAME PUBLIC ${BLAS_INCLUDE_DIRS})
    #target_link_libraries(OUR_PROJECT_NAME ${BLAS_LIBRARIES})
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # Qt5
    #--------------------------------------------------
    # If you project depends on Qt, uncomment me
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # set(CMAKE_AUTOMOC ON)
    # set(CMAKE_INCLUDE_CURRENT_DIR ON)
    # # CAVEAT:
    # # When Qt is used, it may be important to use POSITION_INDEPENDENT_CODE property to avoid error message like:
    # #       >> You must build your code with position independent code if Qt was built with -reduce-relocations. 
    # #          Compile your code with -fPIC (-fPIE is not enough). <<
    # # (see: http://qt.apidoc.info/5.2.0/qtdoc/cmake-manual.html)
    # #
    # set(CMAKE_POSITION_INDEPENDENT_CODE ON)
    #
    # find_package(Qt5Widgets REQUIRED)
    # # Add dependency 
    # include_directories(${Qt5Widgets_INCLUDE_DIRS})
    # target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5Widgets_INCLUDE_DIRS})
    # # CAVEAT: do not use target_link_libraries(OUR_PROJECT_NAME ${Qt5Widgets_LIBRARIES}) but
    # get_target_property(QtWidgets_location Qt5::Widgets LOCATION)
    # # as described in http://doc.qt.io/qt-5/cmake-manual.html
    # target_link_libraries(OUR_PROJECT_NAME ${Qt5Widgets_location})
    #
    # find_package(Qt5Core REQUIRED)
    # # Add dependency 
    # include_directories(${Qt5Core_INCLUDE_DIRS})
    # target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5Core_INCLUDE_DIRS})
    # # CAVEAT: do not use target_link_libraries(OUR_PROJECT_NAME ${Qt5Core_LIBRARIES}), but
    # get_target_property(QtCore_location Qt5::Core LOCATION)
    # # as described in http://doc.qt.io/qt-5/cmake-manual.html
    # target_link_libraries(OUR_PROJECT_NAME ${Qt5Core_location})
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # Qwt
    #--------------------------------------------------
    # If you project depends on Qwt, uncomment me
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # find_package(Qwt REQUIRED)
    # include_directories(${QWT_INCLUDE_DIRS})
    # target_include_directories(OUR_PROJECT_NAME PUBLIC ${QWT_INCLUDE_DIRS})
    # target_link_libraries(OUR_PROJECT_NAME ${QWT_LIBRARIES})
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # CAVEAT: you must add your own FindQwt.cmake in 
    #         the OUR_PROJECT_NAME/cmake directory
    #         You can find one at:
    #         http://www.cmake.org/Wiki/CMakeUserFindQwt
    #         https://github.com/qgis/QGIS/blob/master/cmake/FindQwt.cmake
    ```

    </div>

    </div>

3.  <span id="sec-2-3-6-3"></span>The **ConfigTesting.cmake** file\
    <div id="text-2-3-6-3" class="outline-text-5">

    <div class="org-src-container">

    ``` {#ConfigTesting.cmake .src .src-txt}
    #==================================================
    # Automatically generated, but not overwritten
    #
    # Adapted from: https://github.com/bast/cmake-example/tree/master/cmake
    #==================================================
    # set cdash buildname
    set(BUILDNAME
        "${CMAKE_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}-${CMAKE_Fortran_COMPILER_ID}-${cmake_build_type_tolower}"
        CACHE STRING
        "Name of build on the dashboard"
        )

    # The following are required to uses Dart and the CDash dashboard
    include(CTest)
    enable_testing()
    ```

    </div>

    </div>

4.  <span id="sec-2-3-6-4"></span>The **OurProjectNameConfig.cmake.in**
    file\
    <div id="text-2-3-6-4" class="outline-text-5">

    For more tuning you can modify this file.

    <div class="org-src-container">

    ``` {#OurProjectNameConfig.cmake.in .src .src-txt}
    #==================================================
    # Automatically generated, but not overwritten
    #==================================================
    # see: http://www.cmake.org/cmake/help/v3.0/variable/CMAKE_CURRENT_LIST_DIR.html
    #      http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html

    include("${CMAKE_CURRENT_LIST_DIR}/OUR_PROJECT_NAMETargets.cmake")
    ```

    </div>

    </div>

5.  <span id="sec-2-3-6-5"></span><span id="in-source-build"></span> The
    **ConfigSafeGuards.cmake** file\
    <div id="text-2-3-6-5" class="outline-text-5">

    <div class="org-src-container">

    ``` {#ConfigSafeGuards.cmake .src .src-txt}
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
    ```

    </div>

    </div>

6.  <span id="sec-2-3-6-6"></span>The **FindGit.cmake** file\
    <div id="text-2-3-6-6" class="outline-text-5">

    <div class="org-src-container">

    ``` {#FindGit.cmake .src .src-txt}
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
    ```

    </div>

    </div>

7.  <span id="sec-2-3-6-7"></span>The **ConfigGitRevision.cmake** file\
    <div id="text-2-3-6-7" class="outline-text-5">

    <div class="org-src-container">

    ``` {#ConfigGitRevision.cmake .src .src-txt}
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
    ```

    </div>

    </div>

8.  <span id="sec-2-3-6-8"></span>The **config.hpp.in** file\
    <div id="text-2-3-6-8" class="outline-text-5">

    <div class="org-src-container">

    ``` {#config.hpp.in .src .src-txt}
    //==================================================
    // Automatically generated, but not overwritten
    //==================================================
    // CAVEAT: config.hpp.in is never overwritten, but config.hpp is!
    //

    /** @file 
     *  @brief OUR_PROJECT_NAME configuration file
     *  
     *  @attention automatically generated from @b config.hpp.in, do not modify!
     */

    #define OUR_PROJECT_NAME_VERSION_MAJOR @OUR_PROJECT_NAME_VERSION_MAJOR@  
    #define OUR_PROJECT_NAME_VERSION_MINOR @OUR_PROJECT_NAME_VERSION_MINOR@
    #define OUR_PROJECT_NAME_VERSION_PATCH @OUR_PROJECT_NAME_VERSION_PATCH@

    const char *OUR_PROJECT_NAME_GIT_REVISION = "@OUR_PROJECT_NAME_GIT_REVISION@";

    #define OUR_PROJECT_NAME_SYSTEM_NAME @CMAKE_SYSTEM_NAME@
    #define OUR_PROJECT_NAME_HOST_SYSTEM_PROCESSOR @CMAKE_HOST_SYSTEM_PROCESSOR@
    ```

    </div>

    </div>

</div>

</div>

</div>

<div id="outline-container-sec-3" class="outline-2">

<span class="section-number-2">3</span> Catalog of **shell scripts** {#sec-3}
--------------------------------------------------------------------

<div id="text-3" class="outline-text-2">

Contains full listings of the automatically generated scripts.

</div>

<div id="outline-container-sec-3-1" class="outline-3">

### <span class="section-number-3">3.1</span> The **tutorial** scripts {#sec-3-1}

<div id="text-3-1" class="outline-text-3">

</div>

<div id="outline-container-sec-3-1-1" class="outline-4">

#### <span class="section-number-4">3.1.1</span> A simple **project** {#sec-3-1-1}

<div id="text-3-1-1" class="outline-text-4">

The **tutorial/create\_myProject.sh** is defined by:

<div class="org-src-container">

``` {.src .src-sh}
../createProject.sh myProject
```

</div>

The **tutorial/check\_myProject.sh** is defined by:

<div class="org-src-container">

``` {.src .src-sh}
# Create build dir
#
cd myProject
mkdir build
cd build
cmake ..

# Check build
#
make

# Check documentation (generated by Doxygen)
# (open myProject/build/doc/doxygen/index.html with your web browser)
#
make doc

# Check (local) install
#
make DESTDIR=local_install install

# check test 
#
make test

# ctest (+ cdash board)
# 
ctest -D Experimental
```

</div>

</div>

</div>

<div id="outline-container-sec-3-1-2" class="outline-4">

#### <span class="section-number-4">3.1.2</span> A simple **super-project** {#sec-3-1-2}

<div id="text-3-1-2" class="outline-text-4">

The **tutorial/create\_superProject.sh** is defined by:

<div class="org-src-container">

``` {.src .src-sh}
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
```

</div>

The **tutorial/check\_superProject.sh** is defined by:

<div class="org-src-container">

``` {.src .src-sh}
# Create build dir
#
cd superProject
mkdir build
cd build
cmake ..

# Check build
#
make

# check documentation (generated by Doxygen)
#
make doc

# check (local) install
#
make DESTDIR=local_install install

# check test 
#
make test

# ctest (+ cdash board)
# -> create a cdash board before
# ctest -D Experimental
```

</div>

</div>

</div>

</div>

<div id="outline-container-sec-3-2" class="outline-3">

### <span class="section-number-3">3.2</span> The **createProject.sh** script {#sec-3-2}

<div id="text-3-2" class="outline-text-3">

The main script **createProject.sh** that allows automatic generation of
project is defined by:

<div class="org-src-container">

``` {.src .src-sh}
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

echo -e "Create C++ project skeleton: $1"

project_name=$(basename "$1" | tr -st ' ' '_' )
project_path=$(dirname "$1")

#**************************************************
# Create all CMakeLists.txt files
#**************************************************
#

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

#**************************************************
# A script to generate C++ project skeletons
# Fri Jul 24 2015
# V. Picaud,
# https://github.com/vincent-picaud/CMakeScript
#**************************************************

#==================================================
# Automatically generated, but never overwritten
#
# Adapted from: https://github.com/bast/cmake-example/blob/master/CMakeLists.txt
#==================================================
#
cmake_minimum_required(VERSION 3.0)
project(OUR_PROJECT_NAME)
 
# enable fortran, c, and c++ language
#
enable_language(Fortran C CXX)

# OUR_PROJECT_NAME version
#
set(OUR_PROJECT_NAME_VERSION_MAJOR 0)
set(OUR_PROJECT_NAME_VERSION_MINOR 1)
set(OUR_PROJECT_NAME_VERSION_PATCH 0)
set(OUR_PROJECT_NAME_VERSION ${OUR_PROJECT_NAME_VERSION_MAJOR}.${OUR_PROJECT_NAME_VERSION_MINOR}.${OUR_PROJECT_NAME_VERSION_PATCH})

# Location of additional cmake modules
#
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${PROJECT_SOURCE_DIR}/cmake
    )

# Guard against in-source builds and bad build-type strings
#
include(ConfigSafeGuards)

# CTest and CDash stuff
#
include(ConfigTesting)

# Example how to set c++ compiler flags for GNU
#
if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wno-unknown-pragmas -Wno-sign-compare -Woverloaded-virtual -Wwrite-strings -Wno-unused")
    set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g3")
    set(CMAKE_CXX_FLAGS_RELEASE "-O2 -DNDEBUG")
    set(CMAKE_CXX_FLAGS_COVERAGE "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage")
endif()


#--------------------------------------------------
# Header files
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

# Location of header files
#
# CAVEAT: a priori must stay synchronized with OUR_PROJECT_NAME/OUR_PROJECT_NAME/CMakeLists.txt 
#         target_include_directories(...)
#
include_directories(
    # search file in source directories
    ${PROJECT_SOURCE_DIR}/
    # otherwise try in the binary directory 
    # (to include the generated config.hpp for instance)
    ${PROJECT_BINARY_DIR}/
)

#--------------------------------------------------
# Explore sub-directories
#--------------------------------------------------
#
# Our OUR_PROJECT_NAME testing framework (gtest)
#
add_subdirectory(${PROJECT_SOURCE_DIR}/test/)

# Our OUR_PROJECT_NAME library build
#
add_subdirectory(${PROJECT_SOURCE_DIR}/OUR_PROJECT_NAME/)

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

current_file=${project_path}/${project_name}/${project_name}/CMakeLists.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Build OUR_PROJECT_NAME library
# Automatically generated, but not overwritten
#==================================================
#

#--------------------------------------------------
# Collect files and define target for the library
#--------------------------------------------------

# Collect files
# 
file(GLOB_RECURSE OUR_PROJECT_NAME_LIB_SOURCE_CPP *.cpp)
file(GLOB_RECURSE OUR_PROJECT_NAME_LIB_SOURCE_HPP *.hpp)

add_library(OUR_PROJECT_NAME SHARED 
            ${OUR_PROJECT_NAME_LIB_SOURCE_CPP} 
            ${OUR_PROJECT_NAME_LIB_SOURCE_HPP})

# Target properties
#
set_target_properties(OUR_PROJECT_NAME 
                      PROPERTIES PUBLIC_HEADER "${OUR_PROJECT_NAME_LIB_SOURCE_HPP}")


# Here we define the include paths that will be used by our clients.
# see: http://www.cmake.org/cmake/help/v3.0/command/target_include_directories.html
# 
# CAVEAT: a priori must stay synchronized with OUR_PROJECT_NAME/CMakeLists.txt include_directory(...)
#
target_include_directories(OUR_PROJECT_NAME PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/>
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/>
    $<INSTALL_INTERFACE:include/>
)

# Library version
# http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html
#
set_property(TARGET OUR_PROJECT_NAME PROPERTY VERSION ${OUR_PROJECT_NAME_VERSION})
set_property(TARGET OUR_PROJECT_NAME PROPERTY SOVERSION ${OUR_PROJECT_NAME_MAJOR_VERSION})
set_property(TARGET OUR_PROJECT_NAME PROPERTY INTERFACE_OUR_PROJECT_NAME_MAJOR_VERSION ${OUR_PROJECT_NAME_MAJOR_VERSION})
set_property(TARGET OUR_PROJECT_NAME APPEND PROPERTY COMPATIBLE_INTERFACE_STRING "${OUR_PROJECT_NAME_MAJOR_VERSION}")

#--------------------------------------------------
# Include dependencies
#--------------------------------------------------
# You can add/remove what you need in the cmake/OUR_PROJECT_NAMEDependencies.cmake file
#
include(${PROJECT_SOURCE_DIR}/cmake/OUR_PROJECT_NAMEDependencies.cmake)

#--------------------------------------
# Installation
#--------------------------------------

# Install library & header file
install(TARGETS OUR_PROJECT_NAME EXPORT OUR_PROJECT_NAMETargets
  LIBRARY DESTINATION lib/OUR_PROJECT_NAME
  ARCHIVE DESTINATION lib/OUR_PROJECT_NAME
  RUNTIME DESTINATION bin/OUR_PROJECT_NAME
  PUBLIC_HEADER DESTINATION include/OUR_PROJECT_NAME
)

# Do not forget config.hpp
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/config.hpp"
  DESTINATION
    include/OUR_PROJECT_NAME
)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/bin/CMakeLists.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Build OUR_PROJECT_NAME executables
# Automatically generated, but not overwritten
#==================================================
#

# Collect files
# --------------------------------------------------
#
file(GLOB_RECURSE ALL_SOURCES_CPP *.cpp)

# For each executables
# --------------------------------------------------
#
foreach(ONE_SOURCE_CPP ${ALL_SOURCES_CPP})

# Build it!
#
get_filename_component(ONE_SOURCE_EXEC ${ONE_SOURCE_CPP} NAME_WE)
# Avoid name collision 
# (trick found at:http://cmake.3232098.n2.nabble.com/What-is-the-preferred-way-to-avoid-quot-same-name-already-exists-quot-error-td7585687.html)
add_executable(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} ${ONE_SOURCE_CPP})
set_target_properties(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} PROPERTIES OUTPUT_NAME ${ONE_SOURCE_EXEC}) 
target_link_libraries(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} OUR_PROJECT_NAME)

# Install (& Export) for external usage
#
install(TARGETS OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} 
        EXPORT OUR_PROJECT_NAMETargets
        RUNTIME DESTINATION bin)
endforeach()


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/examples/CMakeLists.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# OUR_PROJECT_NAME executables
# Automatically generated, but not overwritten
#==================================================
#

# Collect files
# --------------------------------------------------
#
file(GLOB_RECURSE ALL_SOURCES_CPP *.cpp)

# For each examples
# --------------------------------------------------
#
foreach(ONE_SOURCE_CPP ${ALL_SOURCES_CPP})

# Build it!
#
get_filename_component(ONE_SOURCE_EXEC ${ONE_SOURCE_CPP} NAME_WE)
# Avoid name collision 
# (trick found at:http://cmake.3232098.n2.nabble.com/What-is-the-preferred-way-to-avoid-quot-same-name-already-exists-quot-error-td7585687.html)
add_executable(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} ${ONE_SOURCE_CPP})
set_target_properties(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} PROPERTIES OUTPUT_NAME ${ONE_SOURCE_EXEC}) 
target_link_libraries(OUR_PROJECT_NAME_${ONE_SOURCE_EXEC} OUR_PROJECT_NAME)

# CAVEAT: no installation, examples are not exported from the build-tree
#
endforeach()


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/doc/doxygen/CMakeLists.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
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

current_file=${project_path}/${project_name}/test/CMakeLists.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# OUR_PROJECT_NAME unit tests
# Automatically generated, but not overwritten
#==================================================
#

# find GTest
#--------------------------------------------------

find_package(Threads REQUIRED)
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

# Generate tests and associated targets
#--------------------------------------------------
file(GLOB_RECURSE ALL_TESTS_CPP *.cpp)

foreach(ONE_TEST_CPP ${ALL_TESTS_CPP})
   # Build it!
   #
   get_filename_component(ONE_TEST_EXEC ${ONE_TEST_CPP} NAME_WE)
   # Avoid name collision 
   # (trick found at:http://cmake.3232098.n2.nabble.com/What-is-the-preferred-way-to-avoid-quot-same-name-already-exists-quot-error-td7585687.html)
   add_executable(OUR_PROJECT_NAME_${ONE_TEST_EXEC} ${ONE_TEST_CPP})
   set_target_properties(OUR_PROJECT_NAME_${ONE_TEST_EXEC} PROPERTIES OUTPUT_NAME ${ONE_TEST_EXEC}) 
   target_link_libraries(OUR_PROJECT_NAME_${ONE_TEST_EXEC} 
                         OUR_PROJECT_NAME
                         ${GTEST_BOTH_LIBRARIES}
                         ${CMAKE_THREAD_LIBS_INIT})
   # CTest
   add_test(OUR_PROJECT_NAME_${ONE_TEST_EXEC} ${ONE_TEST_EXEC})
endforeach()


//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************
# Create all C++ files
#**************************************************

current_file=${project_path}/${project_name}/test/toRemove_check_git_hash.cpp
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#include "gtest/gtest.h"
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>

using namespace OUR_PROJECT_NAME;

TEST(Demo,Trivial) {
   EXPECT_TRUE(true);
}

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/${project_name}/toRemove_git_hash.hpp
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

/** @file
 *  @brief A file from the OUR_PROJECT_NAME library
 */
#include <string>

namespace OUR_PROJECT_NAME {

/** @brief A function that returns the git hash
 *
 *  Its role is to check link with @ref toRemove_OUR_PROJECT_NAME_git_hash.cpp
 */
std::string git_hash();

} /* OUR_PROJECT_NAME */

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/${project_name}/toRemove_git_hash.cpp
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>
#include <OUR_PROJECT_NAME/config.hpp>

namespace OUR_PROJECT_NAME {

std::string git_hash()
{
    return std::string(OUR_PROJECT_NAME_GIT_REVISION);
}

} /* OUR_PROJECT_NAME */

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/bin/toRemove_${project_name}_git_hash.cpp
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

/** @file
 *  @brief A file from the OUR_PROJECT_NAME binary directory
 */
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>
#include <iostream>

using namespace OUR_PROJECT_NAME;

/** @brief Returns the git hash
 *
 *  Usage:
 *  @code
 *  ./toRemove_OUR_PROJECT_NAME_git_hash
 *  @endcode
 *
 *  @note this executable is installed in @b bin/
 */
int main()
{
    std::cout << "\nCurrent git hash is " << git_hash();
}

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/examples/toRemove_example.cpp
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

/** @file
 *  @brief A file from the OUR_PROJECT_NAME examples directory
 *
 *  @include toRemove_example.cpp
 *
 *  Also note that you can:
 *    - include figures: @image html figures/one_figure.png
 *
 *    - use bibliographic reference @cite Heesch2008 
 * 
 */
#include <OUR_PROJECT_NAME/toRemove_git_hash.hpp>
#include <iostream>

using namespace OUR_PROJECT_NAME;

/** @brief Returns the git hash
 *
 *  Usage:
 *  @code
 *  ./toRemove_git_hash
 *  @endcode
 *
 *  @note this executable is @b not installed in @b bin/
 */
int main()
{
   std::cout << "\nCurrent git hash is " << git_hash();
}

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************
# Create Doc stuff
#**************************************************
#
current_file=${project_path}/${project_name}/doc/doxygen/doxyfile.in
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

PROJECT_NAME           = OUR_PROJECT_NAME
PROJECT_NUMBER         = @OUR_PROJECT_NAME_VERSION@

HIDE_UNDOC_MEMBERS     = YES
HIDE_UNDOC_CLASSES     = YES
HIDE_FRIEND_COMPOUNDS  = YES

REPEAT_BRIEF           = NO
ALWAYS_DETAILED_SEC    = NO

CITE_BIB_FILES         = @PROJECT_SOURCE_DIR@/doc/OUR_PROJECT_NAME_bibliography.bib

WARN_LOGFILE           = doxygenError.txt

INPUT                  = @PROJECT_SOURCE_DIR@/OUR_PROJECT_NAME \
                         @PROJECT_SOURCE_DIR@/examples \
                         @PROJECT_SOURCE_DIR@/bin \
                         @PROJECT_SOURCE_DIR@/test

FILE_PATTERNS          = *.hpp *.cpp
RECURSIVE              = YES

EXCLUDE_PATTERNS       =  */moc_/* */_automoc/*
EXAMPLE_PATH           = @PROJECT_SOURCE_DIR@/examples 
EXAMPLE_PATTERNS       = *.cpp
EXAMPLE_RECURSIVE      = YES

IMAGE_PATH             = @PROJECT_SOURCE_DIR@/doc/figures/

EXTRA_PACKAGES         = mathtools \
                         amsfonts \
                         stmaryrd
             
PREDEFINED             = DOXYGEN_DOC
SKIP_FUNCTION_MACROS   = NO

COLLABORATION_GRAPH    = NO
INCLUDE_GRAPH          = NO
INCLUDED_BY_GRAPH      = NO
GRAPHICAL_HIERARCHY    = NO
DIRECTORY_GRAPH        = NO

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# CAVEAT: Doxygen update doxyfile.in
#
#doxygen -u "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/doc/${project_name}_bibliography.bib
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
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
current_file=${project_path}/${project_name}/doc/figures/readme.txt
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

Put your figures here (one_figure.png file for instance)

They can be included in the doxygen doc with:

/*

 ...

 * @image html figures/one_figure.png

 ...

 */

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************
# Create the OUR_PROJECT_NAME/cmake/ files.
#**************************************************
#
current_file=${project_path}/${project_name}/cmake/${project_name}Config.cmake.in
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#==================================================
# see: http://www.cmake.org/cmake/help/v3.0/variable/CMAKE_CURRENT_LIST_DIR.html
#      http://www.cmake.org/cmake/help/v3.0/manual/cmake-packages.7.html

include("${CMAKE_CURRENT_LIST_DIR}/OUR_PROJECT_NAMETargets.cmake")

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/cmake/${project_name}Dependencies.cmake
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
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
# For a "Super-Project" containing projectUpstream and OUR_PROJECT_NAME,
# if OUR_PROJECT_NAME depends on projectUpstream, simply uncomment me
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# if(NOT TARGET projectUpstream)
# find_package(projectUpstream CONFIG REQUIRED)
# if(NOT ${projectUpstream_FOUND}) 
#    message(FATAL_ERROR "Did not found projectUpstream module!")
# endif()
# endif()
# target_link_libraries(OUR_PROJECT_NAME projectUpstream)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Note: the role of the if(NOT TARGET projectUpstream) guard is only relevant in case
#       of super-project build where "projectUpstream" is included by add_subdirectory
#       from a master CMakeLists.txt file.
#       In that case the file projectUpstreamTargets.cmake is not yet generated and
#       find_package(projectUpstream CONFIG REQUIRED) would generate a "file not found" 
#       error. However the target projectUpstream is already available.

# BLAS
#--------------------------------------------------
# If you project depends on BLAS, uncomment me
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#enable_language(Fortran)
#find_package(BLAS REQUIRED)
#include_directories(${BLAS_INCLUDE_DIRS})
#target_include_directories(OUR_PROJECT_NAME PUBLIC ${BLAS_INCLUDE_DIRS})
#target_link_libraries(OUR_PROJECT_NAME ${BLAS_LIBRARIES})
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Qt5
#--------------------------------------------------
# If you project depends on Qt, uncomment me
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# set(CMAKE_AUTOMOC ON)
# set(CMAKE_INCLUDE_CURRENT_DIR ON)
# # CAVEAT:
# # When Qt is used, it may be important to use POSITION_INDEPENDENT_CODE property to avoid error message like:
# #       >> You must build your code with position independent code if Qt was built with -reduce-relocations. 
# #          Compile your code with -fPIC (-fPIE is not enough). <<
# # (see: http://qt.apidoc.info/5.2.0/qtdoc/cmake-manual.html)
# #
# set(CMAKE_POSITION_INDEPENDENT_CODE ON)
#
# find_package(Qt5Widgets REQUIRED)
# # Add dependency 
# include_directories(${Qt5Widgets_INCLUDE_DIRS})
# target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5Widgets_INCLUDE_DIRS})
# # CAVEAT: do not use target_link_libraries(OUR_PROJECT_NAME ${Qt5Widgets_LIBRARIES}) but
# get_target_property(QtWidgets_location Qt5::Widgets LOCATION)
# # as described in http://doc.qt.io/qt-5/cmake-manual.html
# target_link_libraries(OUR_PROJECT_NAME ${Qt5Widgets_location})
#
# find_package(Qt5Core REQUIRED)
# # Add dependency 
# include_directories(${Qt5Core_INCLUDE_DIRS})
# target_include_directories(OUR_PROJECT_NAME PUBLIC ${Qt5Core_INCLUDE_DIRS})
# # CAVEAT: do not use target_link_libraries(OUR_PROJECT_NAME ${Qt5Core_LIBRARIES}), but
# get_target_property(QtCore_location Qt5::Core LOCATION)
# # as described in http://doc.qt.io/qt-5/cmake-manual.html
# target_link_libraries(OUR_PROJECT_NAME ${Qt5Core_location})
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Qwt
#--------------------------------------------------
# If you project depends on Qwt, uncomment me
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# find_package(Qwt REQUIRED)
# include_directories(${QWT_INCLUDE_DIRS})
# target_include_directories(OUR_PROJECT_NAME PUBLIC ${QWT_INCLUDE_DIRS})
# target_link_libraries(OUR_PROJECT_NAME ${QWT_LIBRARIES})
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CAVEAT: you must add your own FindQwt.cmake in 
#         the OUR_PROJECT_NAME/cmake directory
#         You can find one at:
#         http://www.cmake.org/Wiki/CMakeUserFindQwt
#         https://github.com/qgis/QGIS/blob/master/cmake/FindQwt.cmake

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/CTestConfig.cmake
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")
mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#==================================================

set(CTEST_PROJECT_NAME       "OUR_PROJECT_NAME")
set(CTEST_NIGHTLY_START_TIME "00:00:00 CEST")
set(CTEST_DROP_METHOD        "http")
set(CTEST_DROP_SITE          "my.cdash.org")
set(CTEST_DROP_LOCATION      "/submit.php?project=OUR_PROJECT_NAME")
set(CTEST_DROP_SITE_CDASH    TRUE)
set(CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS 200)

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/cmake/ConfigTesting.cmake
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

#==================================================
# Automatically generated, but not overwritten
#
# Adapted from: https://github.com/bast/cmake-example/tree/master/cmake
#==================================================
# set cdash buildname
set(BUILDNAME
    "${CMAKE_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}-${CMAKE_Fortran_COMPILER_ID}-${cmake_build_type_tolower}"
    CACHE STRING
    "Name of build on the dashboard"
    )

# The following are required to uses Dart and the CDash dashboard
include(CTest)
enable_testing()

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
fi

#**************************************************

current_file=${project_path}/${project_name}/cmake/ConfigSafeGuards.cmake
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
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

current_file=${project_path}/${project_name}/cmake/FindGit.cmake
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
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

current_file=${project_path}/${project_name}/cmake/ConfigGitRevision.cmake
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
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

current_file=${project_path}/${project_name}/cmake/config.hpp.in
#
# Do not overwrite me!
#
if [ ! -f "${current_file}" ]
then
current_file_dir=$(dirname "${current_file}")

mkdir -p ${current_file_dir}
echo "${current_file}" 1>&2
more > "${current_file}" <<'//GO.SYSIN DD PRIVATE_DD_TAG' 

//==================================================
// Automatically generated, but not overwritten
//==================================================
// CAVEAT: config.hpp.in is never overwritten, but config.hpp is!
//

/** @file 
 *  @brief OUR_PROJECT_NAME configuration file
 *  
 *  @attention automatically generated from @b config.hpp.in, do not modify!
 */

#define OUR_PROJECT_NAME_VERSION_MAJOR @OUR_PROJECT_NAME_VERSION_MAJOR@  
#define OUR_PROJECT_NAME_VERSION_MINOR @OUR_PROJECT_NAME_VERSION_MINOR@
#define OUR_PROJECT_NAME_VERSION_PATCH @OUR_PROJECT_NAME_VERSION_PATCH@

const char *OUR_PROJECT_NAME_GIT_REVISION = "@OUR_PROJECT_NAME_GIT_REVISION@";

#define OUR_PROJECT_NAME_SYSTEM_NAME @CMAKE_SYSTEM_NAME@
#define OUR_PROJECT_NAME_HOST_SYSTEM_PROCESSOR @CMAKE_HOST_SYSTEM_PROCESSOR@

//GO.SYSIN DD PRIVATE_DD_TAG
sed -i 's/OUR_PROJECT_NAME/'${project_name}'/g' "${current_file}"
#
# Read only
#
chmod 0444 "${current_file}"
fi
```

</div>

</div>

<div id="outline-container-sec-3-2-1" class="outline-4">

#### <span class="section-number-4">3.2.1</span> The **createEmptyProject.sh** script {#sec-3-2-1}

<div id="text-3-2-1" class="outline-text-4">

This is only a convenience script that allows to create the **directory
structure** of a project. You can create this directory structure, fill
it with your c++ source files and then finally invoke the
**createProject.sh** script to create the **CMakeLists.txt**…

<div class="org-src-container">

``` {.src .src-sh}
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

project_name=$(basename "$1" | tr -st ' ' '_' )
project_path=$(dirname "$1")

mkdir -p ${project_path}/${project_name}/${project_name}
mkdir -p ${project_path}/${project_name}/bin
mkdir -p ${project_path}/${project_name}/examples
mkdir -p ${project_path}/${project_name}/test
mkdir -p ${project_path}/${project_name}/doc/doxygen/
mkdir -p ${project_path}/${project_name}/doc/figures
mkdir -p ${project_path}/${project_name}/cmake
```

</div>

</div>

</div>

</div>

</div>

</div>

<div id="postamble" class="status">

Author: Vincent Picaud

Created: 2015-07-26 Sun 09:23

[Emacs](http://www.gnu.org/software/emacs/) 24.5.1
([Org](http://orgmode.org) mode 8.2.10)

[Validate](http://validator.w3.org/check?uri=referer)

</div>
