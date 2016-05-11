#include <qapplication.h>
#include <project_Qt_Qwt/mainwindow.h>

int main ( int argc, char **argv )
{
    QApplication a( argc, argv );

    MainWindow w;
    w.resize( 540, 400 );
    w.show();

    return a.exec();
}
