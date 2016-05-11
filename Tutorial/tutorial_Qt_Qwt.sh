../createProject.sh project_Qt_Qwt
cd project_Qt_Qwt/
mkdir build
cd build/
cmake -Dproject_Qt_Qwt_USE_QT5=ON -Dproject_Qt_Qwt_USE_QWT=ON ..
make
