cd Tutorial/
../createProject.sh project_A
cd project_A/
mkdir build
cd build/
cmake ..
make
make test
make doc
make DESTDIR=path_to_local_install install
