rm -rf myProject
../createProject.sh myProject

# Create build dir
#
cd myProject
mkdir build
cd build
cmake ..

# Check build
#
make -j

# Check documentation (generated by Doxygen)
#
make doc

# Check (local) install
#
make DESTDIR=local_install install

# check test 
#
make test
